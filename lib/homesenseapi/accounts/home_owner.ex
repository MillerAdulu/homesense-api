defmodule Homesenseapi.Accounts.HomeOwner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "homeowners" do
    field :email, :string
    field :id_number, :string
    field :name, :string
    field :phone_number, :string

    timestamps()
  end

  @doc false
  def changeset(home_owner, attrs) do
    home_owner
    |> cast(attrs, [:id_number, :name, :phone_number, :email])
    |> validate_required([:id_number, :name, :phone_number, :email])
    |> unique_constraint(:id_number)
    |> unique_constraint(:phone_number)
    |> unique_constraint(:email)
  end
end
