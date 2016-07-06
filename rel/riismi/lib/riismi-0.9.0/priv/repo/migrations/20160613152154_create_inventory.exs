defmodule Riismi.Repo.Migrations.CreateInventories do
  use Ecto.Migration

  def change do
    create table(:inventory) do
      add :machine_id, :string
      add :sw_name, :string
      add :sw_version, :string
      add :new_record, :boolean
      timestamps
    end
  end
end
