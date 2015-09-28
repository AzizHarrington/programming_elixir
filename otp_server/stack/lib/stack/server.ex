defmodule Stack.Server do
  use GenServer

  #####
  # External API

  def start_link(stack) do
    GenServer.start_link(__MODULE__, stack, name: __MODULE__)
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(item) do
    GenServer.cast __MODULE__, {:push, item}
  end

  #####
  # GenServer implementation

  def handle_call({:initialize, data}, _from, stack) do
    { :reply, :ok, data}
  end

  def handle_call(:pop, _from, []) do
    { :stop, :shutdown, [] }
  end

  def handle_call(:pop, _from, stack) do
    [ head | tail ] = stack
    { :reply, head, tail }
  end

  def handle_cast({:push, item}, stack) do
    { :noreply, [ item | stack ]}
  end

  def terminate(reason, stack) do
    IO.puts """
      Stack terminated: #{inspect reason}
      stack contents: #{inspect stack}
    """
    :ok
  end
end
