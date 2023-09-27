defmodule ExBank.Contracts.User.Get do
  use CleanArchitecture.Contract

  embedded_schema do
    field :id, :string
  end

  def changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, [:id])
    |> validate_required([:id])
  end
end
