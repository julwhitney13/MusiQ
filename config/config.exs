# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :musiq,
  ecto_repos: [Musiq.Repo]

# Configures the endpoint
config :musiq, MusiqWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gcqIgf0U+/hEBV/NRflSFrpYZlvSYIJtQJ1AyF3LomDxz/EUuTt7KHbYm3wn3nFY",
  render_errors: [view: MusiqWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Musiq.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
