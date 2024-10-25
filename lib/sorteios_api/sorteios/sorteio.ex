defmodule SorteiosApi.Raffles.Raffle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raffles" do
    field :name, :string
    field :date, :naive_datetime  

    timestamps()
  end

  def changeset(raffle, attrs) do
    raffle
    |> cast(attrs, [:name, :date])
    |> validate_required([:name, :date])
  end
end
