defmodule ExBank.Entities.Address do
  use CleanArchitecture.Entity
  import Ecto.Changeset
  alias ExBank.Entities.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @fields [:street, :number, :neighborhood, :city, :state, :country]
  @requireds @fields

  schema "adresses" do
    field :street, :string
    field :number, :string
    field :neighborhood, :string
    field :city, :string
    field :state, :string
    field :country, :string
    field :zip_code, :string
    belongs_to :user, User

    timestamps()
  end

  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(address, attrs) do
    address
    |> cast(attrs, @fields)
    |> validate_required(@requireds)
  end
end
