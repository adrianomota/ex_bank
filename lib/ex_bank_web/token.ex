defmodule ExBankWeb.Token do
  alias ExBankWeb.Endpoint
  alias Phoenix.Token

  @salt "my-secret-salt"

  def generate(user) do
    Token.sign(Endpoint, @salt, %{user_id: user.id})
    IO.inspect(user.id)
  end

  def verify(token) do
    Token.verify(Endpoint, @salt, token)
  end
end
