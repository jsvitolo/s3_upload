# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :s3_upload,
  ecto_repos: [S3Upload.Repo]

# Config ex_aws S3
config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  s3: [
    scheme: "https://",
    host: "vilagenet.s3.amazonaws.com",
    region: "sa-east-1"
  ]

# Configures the endpoint
config :s3_upload, S3UploadWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JxSFimCq5PFOZLzAF0Kvo9QrVa2ashrj04Ii35vQKE2vBNHUOIqxgiIaoRDvxhU4",
  render_errors: [view: S3UploadWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: S3Upload.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
