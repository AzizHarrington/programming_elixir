defmodule Ex1 do
  def run do
    Process.flag :trap_exit, true
    spawn_monitor Ex1, :foo, [self]
    :timer.sleep 500
    receive_messages
  end

  def receive_messages do
    receive do
      msg ->
        IO.inspect msg
        receive_messages
      after 1000 ->
        IO.puts 'no more messages'
    end
  end

  def foo(pid) do
    send pid, :bar
    exit :boom
  end
end
