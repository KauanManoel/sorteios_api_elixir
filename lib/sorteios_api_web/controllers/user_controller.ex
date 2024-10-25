defmodule SorteiosApiWeb.UserController do

  use SorteiosApiWeb, :controller

  alias SorteiosApi.Accounts
  alias SorteiosApi.Accounts.User

  # List all users
  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  # Create a new user
  def create(conn, %{"email" => email, "name" => name}) do
    case User.create_user(%{name: name, email: email}) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> json(user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(changeset)
    end
  end  # Show a single user by ID
  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  # Update a user by ID
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset: changeset)
    end
  end
  
  # Delete a user by ID
  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    else
      {:error, _reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Unable to delete user"}) # Trate erro de deletar
    end
  
end
end
