defmodule Homesenseapi.Devices.Homesense do
  use Ecto.Schema
  import Ecto.Changeset

  schema "homesenses" do
    field :area, :string
    field :latitude, :decimal
    field :longitude, :decimal
    field :notes, :string
    belongs_to :homeowner, Homesenseapi.Accounts.HomeOwner

    timestamps()
  end

  @doc false
  def changeset(homesense, attrs) do
    homesense
    |> cast(attrs, [:longitude, :latitude, :area, :notes, :homeowner_id])
    |> validate_required([:longitude, :latitude, :area, :notes, :homeowner_id])
    |> foreign_key_constraint(:homeowner_id)
  end
end
