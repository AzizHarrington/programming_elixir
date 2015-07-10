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

  @doc """
    Takes a nested list structure and flattens it
  """
  def flatten([]) do
    []
  end

  def flatten([ [ head | [] ] | tail ]) do
    flatten([ head | tail ])
  end

  def flatten([ [ head | tail1 ] | tail2 ]) do
    flatten([ head | [ tail1 | tail2 ] ])
  end

  def flatten( [ head | tail ] ) do
    [ head | flatten(tail) ]
  end

  @doc """
    Returns primes numbers 2 to n
  """
  def primes(bound) do
    sieve(Enum.to_list 2..bound)
  end

  def sieve([]) do
    []
  end

  def sieve([ head | tail ]) do
    [ head | sieve( for x <- tail, rem(x, head) > 0, do: x) ]
  end
end
