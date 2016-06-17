defmodule Riismi.File do
  @file_directory Riismi.datafile_path()

  @spec start_watcher(Path.t)::pid()
  def start_watcher(path \\ @file_directory) do
    case :fs.start_link(:fswatcher, Path.relative_to_cwd(path)) do
      {:ok, fswatcher} ->
        fswatcher
      {:error, {:already_started, fswatcher}} ->
        fswatcher
    end
  end

  @spec watch_for_inventory_files(pid())::no_return()
  def watch_for_inventory_files(fswatcher) when is_pid(fswatcher) do
    :fs.subscribe(fswatcher)

    receive do
      {_watcher_process, {:fs, :file_event}, {changedFile, [:created]}} ->
        IO.puts("#{changedFile} was created")
      {_watcher_process, {:fs, :file_event}, {changedFile, [:modified]}} ->
        IO.puts("#{changedFile} was modified")
      {_watcher_process, {:fs, :file_event}, {changedFile, [:removed]}} ->
        IO.puts("#{changedFile} was deleted")
    end
    watch_for_inventory_files(fswatcher)
  end

end
