defmodule SorteiosApi.Participation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "participations" do
    field :user_id, :integer
    field :raffle_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(participation, attrs) do
    participation
    |> cast(attrs, [:user_id, :raffle_id])
    |> validate_required([:user_id, :raffle_id]) 
  end
end
