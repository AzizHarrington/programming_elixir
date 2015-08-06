defmodule SpawnTwo do
  def run do
    pid1 = spawn(SpawnTwo, :echo_delay, [])
    pid2 = spawn(SpawnTwo, :echo_delay, [])

    send pid1, {self, :foo, :random.uniform(5)}
    send pid2, {self, :bar, :random.uniform(5)}

    receive do
      # make deterministic by matching
      # on the pids
      {^pid1, :ok, message} ->
        IO.puts message
    end
    receive do
      {^pid2, :ok, message} ->
        IO.puts message
    end
  end

  def echo_delay do
    receive do
      {sender, message, time} ->
        :timer.sleep time * 1000
        send sender, {self, :ok, message}
    end
  end
end
