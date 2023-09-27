defmodule ExBank.Interactors.Auth.Verify do
  alias ExBank.Interactors.User.FetchByEmail

  def call(%{email: email, password: password}) do
    case FetchByEmail.call(email) do
      {:ok, user} ->
        verify(user, password)

      {:error, _} = error ->
        error
    end
  end

  defp verify(user, password) do
    case Argon2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, :unauthorized}
    end
  end
end
