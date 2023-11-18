defmodule BankAPI.Accounts.Projectors.AccountOpenedTest do
  use BankAPI.ProjectorCase, async: true

  alias BankAPI.Accounts.Events
  alias BankAPI.Accounts.Commands
  alias BankAPI.CommandedApplication

  test "should succeed with valid data" do
    uuid = UUID.uuid4()

    :ok =
      CommandedApplication.dispatch(%Commands.OpenAccount{
        account_uuid: uuid,
        initial_balance: 1_000
      })

    wait_for_event(CommandedApplication, Events.AccountOpened, fn opened ->
      opened.account_uuid == uuid
    end)
  end
end
