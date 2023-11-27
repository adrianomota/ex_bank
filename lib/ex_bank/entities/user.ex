defmodule ExBank.Entities.User do
  use CleanArchitecture.Entity
  import Ecto.Changeset

  alias ExBank.Entities.Address

  @role_field [:role]
  @role_values [:USER, :ADMIN]
  @primary_key {:id, :binary_id, autogenerate: true}
  @fields [:first_name, :last_name, :email, :password, :password_confirmation]
  @requireds @fields

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :role, Ecto.Enum, values: @role_values, default: :USER
    has_many :adresses, Address, on_replace: :delete_if_exists, on_delete: :delete_all
    timestamps()
  end

  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @role_field ++ @fields)
    |> validate_required(@requireds)
    |> validate_format(:email, ~r/@/, message: "type a valid e-mail")
    |> update_change(:email, &String.downcase/1)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash()
    |> cast_assoc(:adresses, with: &Address.changeset/2)
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password_hash: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
