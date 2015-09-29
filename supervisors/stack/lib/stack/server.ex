defmodule Stack.Server do
  use GenServer

  #####
  # External API

  def start_link(current_stack) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, current_stack, name: __MODULE__)
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(item) do
    GenServer.cast __MODULE__, {:push, item}
  end

  #####
  # GenServer implementation

  def init(stash_pid) do
    current_stack = Stack.Stash.get_stack stash_pid
    { :ok, {current_stack, stash_pid} }
  end

  def handle_call(:pop, _from, {[], stash_pid}) do
    { :stop, :shutdown, {[], stash_pid} }
  end

  def handle_call(:pop, _from, {current_stack, stash_pid}) do
    [ head | tail ] = current_stack
    { :reply, head, {tail, stash_pid} }
  end

  def handle_cast({:push, item}, {current_stack, stash_pid}) do
    { :noreply, {[ item | current_stack ], stash_pid} }
  end

  def terminate(reason, {current_stack, stash_pid}) do
    Stack.Stash.save_stack stash_pid, current_stack
  end
end
