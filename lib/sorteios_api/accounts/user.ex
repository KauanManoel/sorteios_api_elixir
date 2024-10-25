defmodule SorteiosApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SorteiosApi.Repo

  @derive {Jason.Encoder, only: [:id, :name, :email, :inserted_at, :updated_at]}
  schema "users" do
    field :name, :string
    field :email, :string
    timestamps()
  end

  def create_user(attrs \\ %{}) do
    %SorteiosApi.Accounts.User{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end

  def list_users do
    Repo.all(User)
  end

end
