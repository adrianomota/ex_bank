defmodule ExBank.Interactors.User.FetchByEmailTest do
  use ExBank.DataCase

  import ExBank.Factory

  alias ExBank.Entities.User
  alias ExBank.Interactors.User.FetchByEmail

  setup do
    user = insert(:user_entity)
    {:ok, user: user}
  end

  describe "call/1" do
    test "When all params are valid, returns ok", %{user: %{email: email}} do
      assert {:ok, %User{}} = FetchByEmail.call(email)
    end

    test "when i have invalid params" do
      %{email: email} = build(:user_contract, %{email: ""})
      assert {:error, "User doesn't exist"} = FetchByEmail.call(email)
    end
  end
end
