defmodule Homesenseapi.Repo.Migrations.CreateHomesenses do
  use Ecto.Migration

  def change do
    create table(:homesenses) do
      add :longitude, :decimal
      add :latitude, :decimal
      add :area, :string
      add :notes, :string
      add :homeowner_id, references(:homeowners, on_delete: :nothing)

      timestamps()
    end

    create index(:homesenses, [:homeowner_id])
  end
end
