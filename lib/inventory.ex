defmodule Riismi.Inventory do
  use Ecto.Schema
  import Ecto.Changeset
  
  schema "inventory" do
    field :machine_id, :string
    field :sw_name, :string
    field :sw_version, :string
    field :new_record, :boolean
    timestamps
  end

  def changeset(inventory, params \\ :empty) do
    inventory
    |> cast(params, ~w(machine_id, sw_name, sw_version, new_record), ~w())
    |> validate_required([:machine_id, :sw_name, :sw_version, :new_record])
  end
  
end
