use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :golixir, GolixirWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :golixir, Golixir.Repo,
  username: "postgres",
  password: "mysecretpassword",
  database: "golixir_test",
  hostname: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox
