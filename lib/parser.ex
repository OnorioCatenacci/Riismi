defmodule Riismi.Parser do
  @sw_name "sw_name"
  @sw_version "sw_version"
  @name_literal "Name="
  @version_literal "Version="
#  @name_regex ~r/^Name=(?<#{@sw_name}>([:w:|:w:-|:w:\+|\.:w:|\(:w:+\)]+ *)*)/
#  @version_regex ~r/^Version=(?<#{@sw_version}>\d+.\d+.\d+(.\d*)?)\r/
  @time_regex ~r/(?<time>^\d{2}:\d{2} [A|P]M\s*$)/
  
  @spec get_software_name(binary)::binary
  defp get_software_name(string) do
    @name_literal <> sw_name = String.trim(string)
    sw_name
  end

  @spec is_software_name?(binary)::boolean
  defp is_software_name?(""), do: false
  defp is_software_name?(@name_literal <> sw_name), do: not(String.trim(sw_name) == "")
  defp is_software_name?(s) when is_binary(s), do: false

  @spec get_software_version(binary)::binary
  defp get_software_version(string) do
    @version_literal <> sw_version = String.trim(string)
    sw_version
  end

  @spec is_software_version?(binary)::boolean
  defp is_software_version?(""), do: false
  defp is_software_version?(@version_literal <> sw_version), do: not(String.trim(sw_version) == "")
  defp is_software_version?(s) when is_binary(s), do: false

  @spec find_most_recent_entries(Path.t)::[binary]
  defp find_most_recent_entries(inventory_file) do
    file_into_list_tailfirst(inventory_file)
    |> Enum.take_while(fn(line) -> not Regex.match?(@time_regex, line) end)
    |> Enum.reverse
  end

  @spec file_into_list_tailfirst(Path.t)::[binary]
  def file_into_list_tailfirst(file) do
    :ok = :io.setopts(:standard_io, encoding: :utf8)
    File.open!(file)
    |> IO.binstream(:line)
    |> Enum.reduce([], fn(line, acc) -> [line|acc] end)
  end

  @spec get_machine_name(Path.t)::String.t
  def get_machine_name(file) do
    #Machine name is the base part of the file name.
    hd(String.split(Path.basename(file),"."))
  end

  
  @spec transform_to_semver([String.t]):: :error | {:ok,%Version{} }
  defp transform_to_semver([major, minor]), do: transform_to_semver([major, minor, "0"])
  defp transform_to_semver([major,minor,patch]), do: Version.parse("#{major}.#{minor}.#{patch}")
  defp transform_to_semver([major,minor,patch,build]),  do: Version.parse("#{major}.#{minor}.#{patch}+#{build}")
    

  @spec compare_versions(String.t, String.t):: :eq | :lt | :gt
  def compare_versions(version_a, version_b) do
    {:ok,a} = transform_to_semver(String.split(version_a, "."))
    {:ok,b} = transform_to_semver(String.split(version_b, "."))
    Version.compare(a,b)
  end
    
  @spec get_name_version_pairs(Path.t)::[%Riismi.Inventory{}]
  def get_name_version_pairs(inventory_file) do
    find_most_recent_entries(inventory_file)
    |> Enum.chunk(2)  #Grab two lines at a time
    |> Enum.reduce([],
    fn ([name|[version]], acc) -> 
      if (is_software_name?(String.trim(name))  && is_software_version?(String.trim(version))) do
        [%Riismi.Inventory{machine_id: get_machine_name(inventory_file), sw_name: "#{get_software_name(name)}",sw_version: "#{get_software_version(version)}", new_record: :true} | acc]
      else
        acc
      end
    end)
  end

end
