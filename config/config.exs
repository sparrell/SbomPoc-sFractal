# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sbom_poc,
  ecto_repos: [SbomPoc.Repo]

# Configures the endpoint
config :sbom_poc, SbomPocWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CXruorR0OIs0Zn+Ue2oTYTkTM/jUU3tTL9LVJWgd7QR/FFMc4G5WE9Wft56wNpgC",
  render_errors: [view: SbomPocWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SbomPoc.PubSub,
  live_view: [signing_salt: "MOt4K6sZ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
