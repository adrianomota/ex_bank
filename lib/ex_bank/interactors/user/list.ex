defmodule ExBank.Interactors.User.List do
  use CleanArchitecture.Interactor
  import CleanArchitecture.Pagination

  alias ExBank.Entities.User
  alias ExBank.Repo

  def call(%{page: page, page_size: page_size} = input) do
    User
    |> filter_by_first_name(input)
    |> filter_by_last_name(input)
    |> filter_by_email(input)
    |> order_by(asc: :first_name)
    |> paginate(Repo, %{page: page, page_size: page_size})
  end

  defp filter_by_first_name(query, %{first_name: first_name}) when not is_nil(first_name) do
    query
    |> where(first_name: ^first_name)
  end

  defp filter_by_first_name(query, _), do: query

  defp filter_by_last_name(query, %{last_name: last_name}) do
    query
    |> where(last_name: ^last_name)
  end

  defp filter_by_last_name(query, _), do: query

  defp filter_by_email(query, %{email: email}) do
    query
    |> where(email: ^email)
  end

  defp filter_by_email(query, _), do: query
end
