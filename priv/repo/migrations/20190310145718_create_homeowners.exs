defmodule Homesenseapi.Repo.Migrations.CreateHomeowners do
  use Ecto.Migration

  def change do
    create table(:homeowners) do
      add :id_number, :string
      add :name, :string
      add :phone_number, :string
      add :email, :string

      timestamps()
    end

    create unique_index(:homeowners, [:id_number])
    create unique_index(:homeowners, [:phone_number])
    create unique_index(:homeowners, [:email])
  end
end
