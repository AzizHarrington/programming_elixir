defmodule Sequence.Stash do
  use GenServer
  require Logger

  @vsn "1"

  #####
  # External API

  def start_link(current_number) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, {current_number, 1}, name: __MODULE__)
  end

  def save_value(pid, {value, delta}) do
    GenServer.cast pid, {:save_value, {value, delta}}
  end

  def get_value(pid) do
    GenServer.call pid, :get_value
  end

  #####
  # GenServer implementation

  def handle_call(:get_value, _from, {value, delta}) do
    { :reply, {value, delta}, {value, delta} }
  end

  def handle_cast({:save_value, {value, delta}}, {_v, _d}) do
    { :noreply, {value, delta} }
  end

  def code_change("0", old_state = current_value, _extra) do
    new_state = {current_value, 1}
    Logger.info "changing code from 0 to 1"
    Logger.info inspect(old_state)
    Logger.info inspect(new_state)
    { :ok, new_state }
  end
end
