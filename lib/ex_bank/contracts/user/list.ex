defmodule ExBank.Contracts.User.List do
  use CleanArchitecture.Contracts.List

  @fields [:first_name, :last_name, :email]

  embedded_schema do
    pagination_schema_fields()
    field :first_name, :string
    field :last_name, :string
    field :email, :string
  end

  def changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, pagination_fields() ++ @fields)
    |> put_default_pagination_changes()
    |> validate_required(pagination_fields())
    |> validate_pagination()
  end
end
