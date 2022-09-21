import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :fizzbuzz, Fizzbuzz.Repo,
  username: "root",
  password: "",
  hostname: "localhost",
  database: "fizzbuzz_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fizzbuzz, FizzbuzzWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "wAzZ6U8Z1WRBYao4XpijHspqcXNtvlRTK9K9GgOViP1aCD7B+cTLvwN3wm6w8SgC",
  server: false

# In test we don't send emails.
config :fizzbuzz, Fizzbuzz.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
