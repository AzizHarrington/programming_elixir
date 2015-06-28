prefix = fn pre ->
  fn word ->
    "#{pre} #{word}"
  end
end

mrs = prefix.("Mrs")
IO.puts mrs.("Smith")
IO.puts prefix.("Elixir").("Rocks")
