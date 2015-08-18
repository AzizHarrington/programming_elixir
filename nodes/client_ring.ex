defmodule Client do

  @interval 2000

  def start do
    pid = spawn_link(__MODULE__, :receiver, [:start?])
    Registrar.register(pid)
  end

  def receiver(action \\ :started) do
    if action == :start? do
      Registrar.start?(self)
    end
    receive do
      { :hello, msg } ->
        IO.puts "received msg"
        IO.puts msg
        Registrar.get_next_client(self)

      { :send_next, pid } ->
        IO.puts "sending msg to #{inspect pid}"
        :timer.sleep(@interval)
        send pid, { :hello, "hello from #{inspect Node.self}" }

      { :wait } ->
        IO.puts "waiting for turn"
    end
    receiver
  end
end

defmodule Registrar do

  @name :registrar

  def start do
    pid = spawn_link(__MODULE__, :registrar, [[], false])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def start?(client_pid) do
    send :global.whereis_name(@name), { :start?, client_pid }
  end

  def get_next_client(client_pid) do
    send :global.whereis_name(@name), { :next_client, client_pid }
  end

  def registrar(clients, started) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        registrar(clients ++ [pid], started)

      { :start?, pid } ->
        IO.puts "deciding to start"
        IO.puts "
        clients: #{inspect clients}
        started: #{inspect started}
        pid: #{inspect pid}

        "
        make_decision(clients, pid, started)

      { :next_client, pid} ->
        IO.puts "checking for next client"
        [ head | tail ] = clients
        send pid, { :send_next, head }
        registrar(tail ++ [head], started)
    end
  end

  defp make_decision(clients, pid, started) do
    [ head | tail ] = clients
    cond do
      head == pid ->
        send pid, { :wait }
        registrar(clients, started)
      started == true ->
        send pid, { :wait }
        registrar(clients, started)
      head != pid and started == false ->
        send pid, { :send_next, head }
        registrar(tail ++ [head], true)
      true ->
        IO.puts "#{inspect clients}, #{inspect started}"
        registrar(clients, started)
    end
  end
end
