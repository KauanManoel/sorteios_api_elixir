defmodule SorteiosApiWeb.RaffleController do
  use SorteiosApiWeb, :controller
  alias SorteiosApi.VariacoesRaffle
  alias SorteiosApiWeb.RaffleJSON
  alias SorteiosApi.Participation
  alias SorteiosApi.Repo
  import Ecto.Query

  def index(conn, _params) do
    raffles = VariacoesRaffle.list_raffles()
    json(conn, RaffleJSON.index(%{raffles: raffles}))
  end

  def create(conn, %{"name" => name, "date" => date}) do
    case VariacoesRaffle.create_raffle(%{name: name, date: date}) do
      {:ok, raffle} ->
        conn
        |> put_status(:created)
        |> json(%{id: raffle.id})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset.errors})
    end
  end

  def participate(conn, %{"raffle_id" => raffle_id, "user_id" => user_id}) do
    IO.inspect(raffle_id, label: "Raffle ID")
    with {:ok, _raffle} <- VariacoesRaffle.get_raffle(raffle_id),
         {:ok, _user} <- VariacoesRaffle.get_user(user_id),
         false <- user_already_participating?(raffle_id, user_id) do

      participation_params = %{user_id: user_id, raffle_id: raffle_id}
      changeset = Participation.changeset(%Participation{}, participation_params)

      case Repo.insert(changeset) do
        {:ok, _participation} ->
          json(conn, %{status: "ok", message: "Participação registrada com sucesso!"})

        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{errors: changeset.errors})
      end
    else
      {:error, _reason} = error ->
        case error do
          {:error, "Sorteio não encontrado."} ->
            conn
            |> put_status(:not_found)
            |> json(%{error: "Sorteio não encontrado."})

          {:error, "Usuário não encontrado."} ->
            conn
            |> put_status(:not_found)
            |> json(%{error: "Usuário não encontrado."})

          _ ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{error: "Erro desconhecido."})
        end

      true ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Usuário já está cadastrado neste sorteio."})
    end
  end

  # Verifica se o usuário já está participando do sorteio
  defp user_already_participating?(raffle_id, user_id) do
    query =
      from p in Participation,
        where: p.raffle_id == ^raffle_id and p.user_id == ^user_id,
        select: p.id

    Repo.exists?(query)
  end

  # Função para obter o resultado do sorteio
  def get_raffle_result(conn, %{"raffle_id" => raffle_id}) do
    case VariacoesRaffle.get_raffle(raffle_id) do
      {:ok, raffle} ->
        if raffle.resultado do
          user = get_winner_user(raffle.resultado)
          json(conn, %{id: user.id, name: user.name, email: user.email})
        else
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{error: "Resultado ainda não disponível."})
        end

      {:error, _reason} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Sorteio não encontrado."})
    end
  end

  defp get_winner_user(user_id) do
    case VariacoesRaffle.get_user(user_id) do
      {:ok, user} -> user
      {:error, _reason} -> nil  # Aqui você pode decidir o que fazer em caso de erro
    end
  end

end
