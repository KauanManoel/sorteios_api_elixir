defmodule SorteiosApiWeb.Router do
  use SorteiosApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SorteiosApiWeb do
    pipe_through :api

    # Rotas para sorteios (raffles)
    resources "/raffles", RaffleController, only: [:index, :create]
    post "/raffles/:raffle_id/participate", RaffleController, :participate
    get "/raffles/:raffle_id/result", RaffleController, :result

    # Rotas para usuários (users)
    resources "/users", UserController, only: [:index, :create, :show, :update, :delete]
  end
end
