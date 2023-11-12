defmodule BankAPI.Accounts.Supervisor do
  use Supervisor

  alias BankAPI.Accounts.Projectors
  alias BankAPI.Accounts.ProcessManagers

  def start_link(init_args) do
    Supervisor.start_link(__MODULE__, init_args, name: __MODULE__)
  end

  def init(_arg) do
    children = [
      # Projectors
      Projectors.AccountOpened,
      Projectors.AccountClosed,
      Projectors.DepositsAndWithdrawals,

      # Process managers
      ProcessManagers.TransferMoney
    ]

    #    supervise(children, strategy: :one_for_one)
    Supervisor.init(children, strategy: :one_for_one)
  end
end
