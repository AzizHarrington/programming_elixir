defmodule MyList do
  def len([]), do: 0
  def len([ _head | tail ]), do: 1 + len(tail)

  def square([]), do: []
  def square([ head | tail ]), do: [ head*head | square(tail) ]

  def add_1([]), do: []
  def add_1([ head | tail ]), do: [ head+1 | add_1(tail) ]

  def sum(list), do: _sum(list, 0)
  defp _sum([], total), do: total
  defp _sum([ head | tail ], total), do: _sum(tail, head+total)

  def sum2([]), do: 0
  def sum2([ head | tail ]), do: head + sum2(tail)

  def map([], _func), do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]

  def reduce([], value, _) do
    value
  end
  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def mapsum(list, func) do
    map(list, func) |> reduce(0, &(&1 + &2))
  end

  def max(list) do
    reduce(list, 0, &_max/2)
  end
  defp _max(a, b) when a > b, do: a
  defp _max(a, b) when a < b, do: b

  def caesar([], _n) do
    []
  end

  def caesar([ head | tail], n) do
    [ _convert(head, n) | caesar(tail, n) ]
  end

  defp _convert(codepoint, n) when codepoint in ?a..?z do
    min..max = ?a..?z
    rem((codepoint + n) - min, max - min + 1) + min
  end

  defp _convert(codepoint, _n) do
    codepoint
  end

  def span(from, to) do
    _span([], to, from..to)
  end
  defp _span(list, count, from..to) when count in from..to do
    _span([ count | list ], count - 1, from..to)
  end
  defp _span(list, _, _) do
    list
  end
end
