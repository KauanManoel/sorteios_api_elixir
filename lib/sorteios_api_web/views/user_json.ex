defmodule SorteiosApiWeb.UserJSON do
  def index(%{users: users}) do
    %{data: Enum.map(users, &user_to_map/1)}
  end

  def user_to_map(%SorteiosApi.Accounts.User{id: id, name: name, email: email, inserted_at: inserted_at, updated_at: updated_at}) do
    %{
      id: id,
      name: name,
      email: email,
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end
end
