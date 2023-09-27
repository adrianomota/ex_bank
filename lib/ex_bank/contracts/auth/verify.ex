defmodule ExBank.Contracts.Auth.Verify do
  use CleanArchitecture.Contract

  @required_fields [:email, :password]

  embedded_schema do
    field :email, :string
    field :password, :string
  end

  def changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/, message: "type a valid e-mail")
    |> validate_length(:password, min: 6, max: 100)
  end
end
