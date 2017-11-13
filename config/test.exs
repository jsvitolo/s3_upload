use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :s3_upload, S3UploadWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :s3_upload, S3Upload.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "s3_upload_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
