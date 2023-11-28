defmodule ExBank do
  alias CleanArchitecture.Contracts
  use CleanArchitecture.BoundedContext

  alias Ecto.Changeset
  alias ExBank.Entities.User
  alias ExBank.Infrastructure.Adapters.Viacep

  def create_user(input) do
    with {:ok, validated_input} <- Contracts.User.Create.validate_input(input),
         {:ok, _} <-
           validated_input |> parse_zip_code_field() |> Viacep.call(),
         {:ok, %User{} = user} <-
           Interactors.User.Create.call(validated_input) do
      {:ok, user}
    else
      {:error, %Changeset{} = changeset} -> {:error, changeset}
      {:error, _reason} = error -> {:error, error}
    end
  end

  def get_user(input) do
    with {:ok, %{id: id}} <- Contracts.User.Get.validate_input(input),
         {:ok, user} <- Interactors.User.Get.call(id) do
      {:ok, user}
    else
      {:error, _message} = reason -> reason
    end
  end

  def list_users(input) do
    with {:ok, validated_input} <- Contracts.User.List.validate_input(input),
         %Pagination{} = users <- Interactors.User.List.call(validated_input) do
      map_pagination_response(users)
    else
      {:error, _message} = reason -> reason
    end
  end

  def login_user(input) do
    with {:ok, validated_input} <- Contracts.Auth.Verify.validate_input(input),
         {:ok, user} <- Interactors.Auth.Verify.call(validated_input) do
      {:ok, user}
    else
      {:error, _message} = reason -> reason
    end
  end

  defp map_pagination_response(%Pagination{
         entries: users,
         page_number: page_number,
         page_size: page_size,
         total_entries: total_entris,
         total_pages: total_pages
       }) do
    {:ok,
     %{
       users: users,
       page_number: page_number,
       page_size: page_size,
       total_entries: total_entris,
       total_pages: total_pages
     }}
  end

  defp parse_zip_code_field(%{adresses: adresses}) do
    Enum.map(adresses, fn address -> address.zip_code end)
  end
end
