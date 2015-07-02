defmodule MyEnum do
  @mdoc """
    My implementations of some basic enumerable protocol functions.
    Only tested on/work on lists at the moment.
  """

  @doc """
    returns true if all elements evaluate when passed to given function.
  """
  def all?(collection, func \\ &(!&1 in [false, nil]), result \\ true)

  def all?([], _func, result) do
    result
  end

  def all?([ head | tail ], func, result) do
    all?(tail, func, func.(head) && result)
  end

  @doc """
    runs the function for each of the elements in the collection
  """
  def each([], _func) do
    :ok
  end

  def each([ head | tail ], func) do
    func.(head)
    each(tail, func)
  end

  @doc """
    filters the collection to only those elements that
    return true when passed to function
  """
  def filter([], _func) do
    []
  end

  def filter([ head | tail ], func) do
    decide(func.(head), [ head | tail], func)
  end

  defp decide(passes, [ head | tail ], func) when passes do
    [ head | filter(tail, func) ]
  end

  defp decide(passes, [ _head | tail ], func) when not passes do
    filter(tail, func)
  end

  @doc """
    splits the collection in two, from the first n/count items,
    and returns them in a tuple
  """
  def split(collection, count) do
    { take(collection, count), _take_right(collection, count, 0) }
  end

  defp _take_right([], _count, _total) do
    []
  end

  defp _take_right([ _head | tail ], count, total) when count > total do
    _take_right(tail, count, total + 1)
  end

  defp _take_right([ head | tail ], count, total) do
    [ head | _take_right(tail, count, total) ]
  end

  @doc """
    Takes the first n/count items from the collection
  """
  def take(collection, count) do
    _take(collection, count, 0)
  end

  defp _take(_collection, count, total) when count == total do
    []
  end

  defp _take([ head | tail ], count, total) do
     [ head | _take(tail, count, total + 1) ]
  end
end
