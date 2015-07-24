defmodule Users do
  aziz = %{ name: "Aziz", state: "IL", likes: "pudding" }

  case aziz do
    %{state: some_state} = person ->
      IO.puts "#{person.name} lives in #{some_state}"
    _ ->
      IO.puts "No matches"
  end
end
