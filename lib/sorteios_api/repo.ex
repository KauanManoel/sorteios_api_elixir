defmodule SorteiosApi.Repo do
  use Ecto.Repo,
    otp_app: :sorteios_api,
    adapter: Ecto.Adapters.Postgres
end
