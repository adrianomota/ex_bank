defmodule ExBank.Repo.Migrations.CreateAddressTable do
  use Ecto.Migration

  alias ExBank.Entities.User

  def change do
    create table(:adresses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :street, :string
      add :number, :string
      add :neighborhood, :string
      add :city, :string
      add :state, :string
      add :country, :string
      add :zip_code, :string

      add :user_id,
          references(:users, type: :binary_id, on_delete: :delete_all, on_update: :update_all),
          null: false

      timestamps()
    end
  end
end
