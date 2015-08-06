defmodule Parallel do
  def pmap(collection, fun) do
    me = self
    collection
    |> Enum.map(fn (elem) ->
         t = :random.uniform(5) * 100
         spawn_link fn ->
           :timer.sleep(t)
           (send me, { self, fun.(elem) })
         end
       end)
    |> Enum.map(fn (pid) ->
         receive do { ^pid, result } -> result end
       end)
  end
end
