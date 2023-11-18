import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bank_api, BankAPIWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ug1fCyvbU+FfuxWCJYAiAMfv6HR21hYXtfYWftZFNvHIUMwmeEzIJ6vzTwzb8cIE",
  server: false

# Print only warnings and errors during test
config :logger,
  level: :warning

# Configure your database
config :bank_api, BankAPI.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "bank_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 20

config :bank_api, BankAPI.CommandedApplication,
  event_store: [
    adapter: Commanded.EventStore.Adapters.InMemory,
    serializer: Commanded.Serialization.JsonSerializer
  ]

config :bank_api, consistency: :strong

config :ex_unit, capture_log: true

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
