defmodule Riismi.File do
  @file_directory Riismi.datafile_path
  @processedfile_directory Riismi.processedfile_path
  @inventory_file_mask "*.txt"

#  def process_inventory_files do
#    Path.wildcard("#{@file_directory}/#{@inventory_file_mask}")
#    |> Enum.map(fn (path) -> Path.basename(path) end)
#    |> add_inventory_records(all_inventory_files)
#  end

#  def move_inventory_file(inventory_file) do
#    source = "#{@file_directory}/#{inventory_file}"
#    {:ok, _bytecount} = File.copy(source, "#{@processedfile_directory}/#{inventory_file}")
#    File.rm(source)
#  end
  

  def add_inventory_records([]), do: nil
#  def add_inventory_records([inventory_file|tail]) do
#    Riismi.Parser.get_name_version_pairs(inventory_file)
#    |> Riismi.Db.insert_new_records
#    move_inventory_file(inventory_file)
#    add_inventory_records(tail)
#  end
end
