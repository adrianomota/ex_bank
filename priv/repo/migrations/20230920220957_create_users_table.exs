defmodule ExBank.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE roles AS ENUM ('USER', 'ADMIN')"
    drop_query = "DROP TYPE roles"

    execute(create_query, drop_query)

    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :role, :roles, default: "USER", null: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
