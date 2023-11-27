defmodule ExBank.Interactors.User.CreateTest do
  use ExBank.DataCase
  import ExBank.Factory

  alias ExBank.Entities.User
  alias ExBank.Interactors.User.Create, as: CreateUser

  setup do
    user = build(:user_contract)
    {:ok, user: user}
  end

  describe "call/1" do
    test "When all params are valid, returns ok", %{user: user} do
      assert {:ok, %User{}} = CreateUser.call(user)
    end

    test "When email param is blank, return error,", %{user: user} do
      user = Map.put(user, :email, "")
      assert {:error, changeset} = CreateUser.call(user)
      assert "can't be blank" in errors_on(changeset).email
    end

    test "When email param is invalid pemail, return error,", %{user: user} do
      user = Map.put(user, :email, "invalidemail.com")
      assert {:error, changeset} = CreateUser.call(user)
      assert "type a valid e-mail" in errors_on(changeset).email
    end
  end
end
