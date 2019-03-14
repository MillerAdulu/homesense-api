defmodule Homesenseapi.Devices.Intrusion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "intrusions" do
    field :intrusion, :boolean
    belongs_to :homesense, Homesenseapi.Devices.Homesense

    timestamps()
  end

  @doc false
  def changeset(intrusion, attrs) do
    intrusion
    |> cast(attrs, [:intrusion, :homesense_id])
    |> validate_required([:intrusion])
    |> foreign_key_constraint(:homesense_id)
  end
end
