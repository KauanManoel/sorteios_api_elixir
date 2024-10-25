defmodule SorteiosApi.Repo.Migrations.CreateRaffles do
  use Ecto.Migration

  def change do
    create table(:raffles) do
      add :name, :string
      add :raffle_date, :naive_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
