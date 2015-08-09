defmodule Count do
  def run(scheduler, dir, token) do
    send scheduler, { :ready, self }
    receive do
      { :run, file, client } ->
        send client, {:result, file, find(token, dir, file), self}
        run(scheduler, dir, token)
      { :shutdown } ->
        exit(:normal)
    end
  end

  defp find(token, dir, file) do
    path = "#{dir}/#{file}"
    if readable(path) do
      contents = File.read! path
      length Regex.scan(~r/#{token}/, contents)
    else
      0
    end
  end

  defp readable(path) do
    stats = File.stat!(path)
    stats.access != :none and stats.type == :regular
  end
end

defmodule Scheduler do
  def run(num_processes, module, func, args, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn_link(module, func, [self | args]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, {:run, next, self}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1,_}, {n2,_} -> n1 <= n2 end)
        end

      {:result, element, result, _pid} ->
        schedule_processes(processes, queue, [ {element, result} | results ])
    end
  end
end

parsed = OptionParser.parse(System.argv)
{[file: dir, token: token], _, _} = parsed
to_process = File.ls! dir

Enum.each 1..100, fn num_processes ->
  {time, result} = :timer.tc(Scheduler, :run,
                             [num_processes, Count, :run, [dir, token], to_process])
  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #  time (s)"
  end
  :io.format "~2B       ~.2f~n", [num_processes, time/1000000.0]
end
