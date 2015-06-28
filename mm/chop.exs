defmodule Chop do
  def guess(actual, low..high) do
    next_guess = div(high - low, 2) + low
    IO.puts "Is it #{next_guess} ?"
    _guess(actual, next_guess, low..high)
  end

  def _guess(actual, actual, _range) do
    IO.puts "Its #{actual}!"
    actual
  end

  def _guess(actual, current, low.._high) when current > actual do
    guess(actual, low..current - 1)
  end

  def _guess(actual, current, _low..high) when current < actual do
    guess(actual, current + 1..high)
  end
end

Chop.guess(273, 1..1000)
