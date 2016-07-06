defmodule Riismi.Db do
  require Ecto.Query
  require Logger
  
  @spec insert_new_records([%Riismi.Inventory{}])::no_return()
  def insert_new_records(record_list) when is_list(record_list) do
    Logger.info("Testing #{length(record_list)} records against existing database records")
    Enum.each(record_list, fn(inventory_record) ->
      %Riismi.Inventory{machine_id: machine, sw_name: sw_name, sw_version: sw_version} = inventory_record
      
      cond do
        software_is_different_version?(machine, sw_name, sw_version) ->
          Logger.info("Updating software version for #{machine}, #{sw_name}, #{sw_version}")
          update_software_version(machine, sw_name, sw_version)
        inventory_record_exists?(machine, sw_name, sw_version) ->
          get_inventory_record(machine, sw_name, sw_version)
          |> mark_record_as_old
        :otherwise ->
          Logger.info("Inserting new record for #{machine}, #{sw_name}, #{sw_version}")
          Riismi.Repo.insert(inventory_record)
      end
      
      end)
  end

  @spec get_inventory_records(binary, binary)::Ecto.Query.t
  def get_inventory_records(machine, sw_name) when is_binary(machine) and is_binary(sw_name) do
    Riismi.Inventory
    |> Ecto.Query.where(machine_id: ^machine)
    |> Ecto.Query.where(sw_name: ^sw_name)
  end

  @spec get_inventory_record(binary, binary, binary)::%Riismi.Inventory{}
  def get_inventory_record(machine, sw_name, sw_version) when is_binary(machine) and is_binary(sw_name) and is_binary(sw_version) do
    Riismi.Inventory
    |> Ecto.Query.where(machine_id: ^machine)
    |> Ecto.Query.where(sw_name: ^sw_name)
    |> Ecto.Query.where(sw_version: ^sw_version)
    |> Riismi.Repo.one!
  end

  #Check by machine and software name
  @spec inventory_record_exists?(binary, binary)::boolean
  def inventory_record_exists?(machine, sw_name) when is_binary(machine) and is_binary(sw_name) do
    get_inventory_records(machine, sw_name)
    |> Riismi.Repo.all
    |> length
    |> Kernel.>=(1)  #true if there is at least one item in the list.
  end

  #Check by machine, software name and version
  @spec inventory_record_exists?(binary, binary, binary)::boolean
  def inventory_record_exists?(machine, sw_name, sw_version) when is_binary(machine) and is_binary(sw_name) and is_binary(sw_version) do
    if inventory_record_exists?(machine, sw_name) do
      Riismi.Inventory
      |> Ecto.Query.where(machine_id: ^machine)
      |> Ecto.Query.where(sw_name: ^sw_name)
      |> Ecto.Query.where(sw_version: ^sw_version)
      |> Riismi.Repo.all
      |> length
      |> Kernel.==(1)
    else
      false
    end
  end

  defp software_is_different_version?(machine, sw_name, sw_version) when is_binary(machine) and is_binary(sw_name) and is_binary(sw_version) do
    inventory_record_exists?(machine, sw_name) and not inventory_record_exists?(machine, sw_name, sw_version)
  end

  @spec set_sw_version(binary, binary)::binary
  def set_sw_version(version_from_db, version_from_file) do
      case Riismi.Parser.compare_versions(version_from_db, version_from_file) do
        :gt ->
          version_from_db
        :lt ->
          version_from_file
        :eq ->
          version_from_db
    end
  end

  @spec get_version_from_inventory_record([%Riismi.Inventory{}])::binary
  defp get_version_from_inventory_record([%Riismi.Inventory{sw_version: old_sw_version}|_] = _r), do: old_sw_version
  
  @spec update_software_version(binary, binary, binary)::no_return()
  def update_software_version(machine, sw_name, version_from_file) do
    record =
      get_inventory_records(machine, sw_name)
      |> Riismi.Repo.all
    
    version = set_sw_version(get_version_from_inventory_record(record),version_from_file)
    if(version == version_from_file) do
      Enum.each(record, fn (r) ->
        Riismi.Inventory.changeset(r, %{new_record: true, sw_version: version})
        |> Riismi.Repo.update
      end)
    end
  end

  @spec get_all_new_software::[%Riismi.Inventory{}]
  def get_all_new_software do
    Riismi.Inventory
    |> Ecto.Query.where(new_record: ^true)
    |> Ecto.Query.order_by([:machine_id, :sw_name] )
    |> Riismi.Repo.all
  end

  
  @spec mark_record_as_old(%Riismi.Inventory{})::no_return()
  def mark_record_as_old(inventory_record) do
    Riismi.Inventory.changeset(inventory_record, %{new_record: false})
    |> Riismi.Repo.update
  end
  
  @spec mark_all_records_as_old()::no_return()  
  def mark_all_records_as_old do
    get_all_new_software
    |> Enum.each(fn(inventory_record) -> mark_record_as_old(inventory_record) end)
  end

  
end
