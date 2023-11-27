defmodule ExBank.Contracts.Address.Create do
  use CleanArchitecture.Contract

  @required_fields [:street, :number, :neighborhood, :city, :state, :country, :zip_code]

  embedded_schema do
    field :street, :string
    field :number, :string
    field :neighborhood, :string
    field :city, :string
    field :state, :string
    field :country, :string
    field :zip_code, :string
  end

  def changeset(%{} = attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(%__MODULE__{} = contract, %{} = attrs) do
    contract
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
