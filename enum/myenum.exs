defmodule MyEnum do
  @mdoc """
    My implementations of some basic enumerable protocol functions.
    Only tested on/work on lists at the moment.
  """

  @doc """
    returns true if all elements evaluate when passed to given function.
  """
  def all?(enumerable, func \\ &(!&1 in [false, nil]), result \\ true)

  def all?([], _func, result) do
    result
  end

  def all?([ head | tail ], func, result) do
    all?(tail, func, func.(head) && result)
  end

  @doc """
    runs the function for each of the elements in the enumerable
  """
  def each([], _func) do
    :ok
  end

  def each([ head | tail ], func) do
    func.(head)
    each(tail, func)
  end

  @doc """
    filters the enumerable to only those elements that
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
    splits the enumerable according at the given element position
  """
  def split do

  end

  @doc """
    Takes the first n items from the enumerable
  """
  def take do

  end
end
