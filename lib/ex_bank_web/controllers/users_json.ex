defmodule ExBankWeb.UsersJSON do
  alias ExBank.Entities.User

  def list(
        %{
          users: users,
          page_number: page_number,
          page_size: page_size,
          total_entries: total_entris,
          total_pages: total_pages
        } = _users
      ) do
    %{
      data: Enum.map(users, &data/1),
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entris,
      total_pages: total_pages
    }
  end

  def create(%{user: user}) do
    %{
      message: "User created successfully.",
      data: data(user)
    }
  end

  def show(%{user: user}) do
    %{
      message: "User gotten successfully.",
      data: data(user)
    }
  end

  def login(%{token: token}) do
    %{
      message: "Token generated successfully.",
      token: token
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      role: user.role
    }
  end
end
