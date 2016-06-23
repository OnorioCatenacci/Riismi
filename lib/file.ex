defmodule Riismi.File do
  @file_directory Riismi.datafile_path
  @inventory_file_mask "*.txt"

  @spec process_inventory_files()::no_return()
  def process_inventory_files do
    Path.wildcard("#{@file_directory}/#{@inventory_file_mask}")
    |> add_inventory_records
    |> Riismi.Db.get_all_new_software
    #Get the list of all new records and send it via e-mail to J. Nolan
  end

  @spec move_inventory_file(binary)::no_return()
  def move_inventory_file(inventory_file) do
    {:ok, _bytecount} = File.copy(inventory_file, "#{Riismi.processedfile_path}/#{Path.basename(inventory_file)}")
    :ok = File.rm(inventory_file)
  end
  
  @spec add_inventory_records([binary])::no_return()
  def add_inventory_records([]), do: nil
  def add_inventory_records([inventory_file|tail]) do
    Riismi.Parser.get_name_version_pairs(inventory_file)
    |> Riismi.Db.insert_new_records
    move_inventory_file(inventory_file)
    add_inventory_records(tail)
  end
end
