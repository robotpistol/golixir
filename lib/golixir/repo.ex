defmodule Golixir.Repo do
  use Ecto.Repo,
    otp_app: :golixir,
    adapter: Ecto.Adapters.Postgres
end
