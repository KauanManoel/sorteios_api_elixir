defmodule SorteiosApi.Sorteios do
  alias SorteiosApi.{Repo, User, Raffle, Participation}
  import Ecto.Query, only: [from: 2]

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def create_raffle(attrs \\ %{}) do
    %Raffle{}
    |> Raffle.changeset(attrs)
    |> Repo.insert()
  end

  def participate_in_raffle(user_id, raffle_id) do
    with {:ok, raffle} <- get_raffle(raffle_id),
         true <- DateTime.compare(raffle.raffle_date, DateTime.utc_now()) == :gt,
         false <- already_participating?(user_id, raffle_id) do
      %Participation{}
      |> Participation.changeset(%{user_id: user_id, raffle_id: raffle_id})
      |> Repo.insert()
    else
      :error -> {:error, "Invalid Raffle"}
      true -> {:error, "Already participating"}
      false -> {:error, "Raffle closed"}
    end
  end

  defp already_participating?(user_id, raffle_id) do
    Repo.exists?(from p in Participation, where: p.user_id == ^user_id and p.raffle_id == ^raffle_id)
  end

  defp get_raffle(id) do
    Repo.get(Raffle, id)
  end
end

