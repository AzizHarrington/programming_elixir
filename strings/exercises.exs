defmodule Exercises do
  def is_ascii(charlist) do
    charlist |> Enum.all? &(?\s <= &1 and &1 <= ?~)
  end

  def is_anagram(word1, word2) do
    compare(word1, word2)
    and compare(word2, word1)
    and length(word1) == length(word2)
  end

  def compare(a, b) do
    a |> Enum.all? &(&1 in b)
  end

  def calculate(expression) do
    #TODO
  end

  def center(strings) do
    #TODO
  end

  def capitalize_sentences(string) do
    #TODO 
  end
end
