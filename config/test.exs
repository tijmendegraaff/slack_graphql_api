use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :slack_graphql_api, SlackGraphqlApiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Speed up password hasing in test env
config :argon2_elixir,
  t_cost: 2,
  m_cost: 12
  
# Configure your database
config :slack_graphql_api, SlackGraphqlApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  # username: "postgres",
  # password: "postgres",
  database: "slack_graphql_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
