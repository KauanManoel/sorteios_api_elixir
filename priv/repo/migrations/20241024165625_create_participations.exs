defmodule SorteiosApi.Repo.Migrations.CreateParticipations do
  use Ecto.Migration

  def change do
    create table(:participations) do
      add :user_id, references(:users, on_delete: :nothing)
      add :raffle_id, references(:raffles, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:participations, [:user_id])
    create index(:participations, [:raffle_id])
  end
end
