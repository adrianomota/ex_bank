defmodule ExBank.Interactors.User.FetchByEmail do
  use CleanArchitecture.Interactor

  alias ExBank.Entities.User
  alias ExBank.Repo

  def call(email) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> {:ok, user}
      nil -> {:error, "User doesn't exist"}
    end
  end
end
