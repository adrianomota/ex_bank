defmodule ExBankWeb.UsersController do
  use ExBankWeb, :controller
  alias ExBankWeb.Token, as: TokenService

  action_fallback ExBankWeb.FallbackController

  def index(conn, params) do
    with {:ok, users} <- ExBank.list_users(params) do
      conn
      |> put_status(:ok)
      |> render(:list, users)
    end
  end

  def create conn, params do
    with {:ok, user} <- ExBank.create_user(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end

  def show(conn, params) do
    with {:ok, user} <- ExBank.get_user(params) do
      conn
      |> put_status(:ok)
      |> render(:show, user: user)
    end
  end

  def login(conn, params) do
    with {:ok, user} <- ExBank.login_user(params) do
      conn
      |> put_status(:ok)
      |> render(:login, token: TokenService.generate(user))
    end
  end
end
