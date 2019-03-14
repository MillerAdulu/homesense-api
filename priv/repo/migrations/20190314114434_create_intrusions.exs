defmodule Homesenseapi.Repo.Migrations.CreateIntrusions do
  use Ecto.Migration

  def change do
    create table(:intrusions) do
      add :homesense_id, references(:homesenses, on_delete: :nothing)
      add :intrusion, :boolean

      timestamps()
    end

    create index(:intrusions, [:homesense_id])
  end
end
