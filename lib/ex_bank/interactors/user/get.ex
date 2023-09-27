defmodule ExBank.Interactors.User.Get do
  use CleanArchitecture.Interactor

  alias ExBank.Entities.User
  alias ExBank.Repo

  def call(id) do
    case Ecto.UUID.cast(id) do
      {:ok, valid_id} -> fetch_user(valid_id)
      :error -> {:error, "Invalid format"}
    end
  end

  defp fetch_user(id) do
    case Repo.get(User, id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, "User doesn't exist"}
    end
  end
end
