defmodule ExBank.Interactors.User.Create do
  use CleanArchitecture.Interactor

  alias ExBank.Entities.User
  alias ExBank.Repo

  def call(%{} = input) do
    input
    |> User.changeset()
    |> Repo.insert()
  end
end
