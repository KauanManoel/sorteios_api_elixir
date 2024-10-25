defmodule SorteiosApi.VariacoesRaffle do
  alias SorteiosApi.Raffles.Raffle
  alias SorteiosApi.Repo
  alias SorteiosApi.Accounts.User
  import Ecto.Query

  def list_raffles do
    Repo.all(Raffle)
  end

  def create_raffle(attrs) do
    %Raffle{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def changeset(raffle, attrs) do
    raffle
    |> Ecto.Changeset.cast(attrs, [:name, :date])
    |> Ecto.Changeset.validate_required([:name, :date])
  end

  def get_raffle(id) do
    case Repo.get(Raffle, id) do
      nil -> {:error, "Sorteio não encontrado."}
      raffle -> {:ok, raffle}
    end
  end

  def get_user(id) do
    case Repo.get(User, id) do
      nil -> {:error, "Usuário não encontrado."}
      user -> {:ok, user}
    end
  end

   # Função para obter participantes de um sorteio
   def get_participants_for_raffle(raffle_id) do
    Repo.all(
      from p in Participation,
        where: p.raffle_id == ^raffle_id,
        select: p
    )
  end

end
