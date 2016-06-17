defmodule Riismi.Db do
  require Ecto.Query

  def insert_new_records(record_list) when is_list(record_list) do
    Enum.each(record_list, fn(inventory_record) -> Riismi.Repo.insert(inventory_record) end)
  end

  defp get_inventory_record(machine, sw_name) when is_binary(machine) and is_binary(sw_name) do
    Riismi.Inventory
    |> Ecto.Query.where(machine_id: ^machine)
    |> Ecto.Query.where(sw_name: ^sw_name)
  end


  #Check by machine and software name
  def inventory_record_exists?(machine, sw_name) when is_binary(machine) and is_binary(sw_name) do
    get_inventory_record(machine, sw_name)
    |> Riismi.Repo.all
    |> length
    |> Kernel.===(1)  #true if there is one (and only one) item in the list.
  end

  #Check by machine, software name and version
  def inventory_record_exists?(machine, sw_name, sw_version) when is_binary(machine) and is_binary(sw_name) and is_binary(sw_version) do
    if inventory_record_exists?(machine, sw_name) do
      get_inventory_record(machine, sw_name)
      |> Ecto.Query.where(sw_version: ^sw_version)
      |> Riismi.Repo.all
      |> length
      |> Kernel.===(1)
    else
      false
    end
  end
  
      
#   machine_id: "MC16",
#  new_record: true, sw_name: "hppCLJCM2320", sw_version: "003.001.00097",
#  updated_at: #Ecto.DateTime<2016-06-15 17:49:19>},
  
    
  def mark_all_records_as_old() do
    all_new_recs = Riismi.Inventory |> Ecto.Query.where(new_record: :true) |> Riismi.Repo.all
    Enum.each(all_new_recs, fn(ir) ->
      %{ir | new_record: false}
      |> Riismi.Inventory.changeset
      |> Riismi.Repo.update
    end)
  end
end
