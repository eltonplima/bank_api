defmodule BankAPI.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: BankAPI.PubSub},
      BankAPI.Repo,
      BankAPIWeb.Endpoint,
      BankAPI.CommandedApplication,
      BankAPI.Accounts.Supervisor
    ]

    opts = [strategy: :one_for_one, name: BankAPI.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    BankAPIWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
