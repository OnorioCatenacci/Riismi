defmodule RiismiTest do
  use ExUnit.Case
  doctest Riismi

  @expected_number_of_inventory_records 156
  @test_inventory_machine "MC16"

  setup_all  do
    Riismi.Parser.get_name_version_pairs("#{Riismi.datafile_path()}/MC16.txt")
    |> Riismi.Db.insert_new_records
  end

  test "List returned by parsing a known test file should have the expected size" do
    l = Riismi.Parser.get_name_version_pairs("#{Riismi.datafile_path()}/MC16.txt")
    assert length(l) ===  @expected_number_of_inventory_records
  end

  test "List returned by parsing an empty test file should have the expected size" do
    l = Riismi.Parser.get_name_version_pairs("#{Riismi.datafile_path()}/empty.txt")
    assert length(l) == 0
  end

#  test "List returned by parsing file with a partial entry (name only) should be the expected size" do
#    l = Riismi.Parser.get_name_version_pairs("#{Riismi.datafile_path()}/MC16_OneName.txt")
#    assert length(l) == 2
#  end

#  test "List returned by parsing file with a partial entry (version only) should be the expected size" do
#    l = Riismi.Parser.get_name_version_pairs("#{Riismi.datafile_path()}/MC16_OneVersion.txt")
#    assert length(l) == 2
#  end

  test "Machine name should be parsed correctly from file name" do
    machine_name = Riismi.Parser.get_machine_name("#Riismi.datafile_path()/MC16.txt")
    assert machine_name == @test_inventory_machine
  end

  test "Inserting records from a known test file should end up with the expected number of records in the database" do
    #Reset the database 
    require Ecto.Query
    all_new_recs = Riismi.Inventory |> Ecto.Query.where(new_record: :true) |> Riismi.Repo.all
    assert length(all_new_recs) ===  @expected_number_of_inventory_records
  end

  test "We should find specific software in the database" do
    assert (Riismi.Db.inventory_record_exists?("MC16","hppCLJCM2320"))
    assert (Riismi.Db.inventory_record_exists?("MC16","hppCLJCM2320", "003.001.00097"))
  end
  
  
  #  test "List returned by parsing a known test file should contain an expected key" do
  #    l = Riismi.Parser.get_name_version_pairs("MC16","#{Riismi.datafile()}/MC16.txt")
  #    assert Map.fetch(l,"Sococo",1)
  #  end
end
