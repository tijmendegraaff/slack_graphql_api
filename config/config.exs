# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :slack_graphql_api, ecto_repos: [SlackGraphqlApi.Repo]

# Configures the endpoint
config :slack_graphql_api, SlackGraphqlApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("ENDPOINT_SECRET_KEY_BASE"),
  render_errors: [view: SlackGraphqlApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: SlackGraphqlApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Guardian for creating token
config :slack_graphql_api, SlackGraphqlApi.Guardian,
  issuer: "slack_graphql_api",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

# Configure AWS s3 upload keys
config :ex_aws,
  access_key_id: System.get_env("AWS_ACCES_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCES_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
