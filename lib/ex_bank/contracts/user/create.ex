defmodule ExBank.Contracts.User.Create do
  use CleanArchitecture.Contract

  @role_values [:USER, :ADMIN]
  @required_fields [:first_name, :last_name, :email, :password, :password_confirmation]

  embedded_schema do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string
    field :password_confirmation
    field :password_hash, :string
    field :role, Ecto.Enum, values: @role_values, default: :USER
  end

  def changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/, message: "type a valid e-mail")
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password)
    |> validate_inclusion(:role, @role_values)
  end
end
