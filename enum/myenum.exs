defmodule MyEnum do
  def all?(enumerable, func \\ &(!&1 in [false, nil]), result \\ true)

  def all?([], _func, result) do
    result
  end

  def all?([ head | tail ], func, result) do
    all?(tail, func, func.(head) && result)
  end

  def each do

  end

  def filter do

  end

  def split do

  end

  def take do

  end
end
