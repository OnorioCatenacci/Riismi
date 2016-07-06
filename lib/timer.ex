defmodule Riismi.Timer do
  use GenServer
  @mins_per_hour 60
  @secs_per_min 60
  @millisecs_per_sec 1000

  def get_interval do
    case Float.parse(Application.get_env(:riismi, :run_time_in_hours)) do
      :error ->
        String.to_integer(Application.get_env(:riismi, :run_time_in_hours))
      {interval,_} ->
        interval
    end
  end
  
  def convert_hours_to_millisecs(hours) when is_number(hours), do: round(hours * @mins_per_hour * @secs_per_min * @millisecs_per_sec)
  def start_link do
    GenServer.start_link(__MODULE__,%{})
  end

  def init(state) do
    Process.send_after(self(), :work, convert_hours_to_millisecs(get_interval))
    {:ok, state}
  end

  def handle_info(:work, state) do
    Riismi.File.process_inventory_files
    Process.send_after(self(), :work, convert_hours_to_millisecs(get_interval))
    {:noreply, state}
  end
end
