defmodule Bouncer do
  aziz = %{name: "Aziz", age: 27}

  case aziz do
    person = %{age: age} when is_number(age) and age >= 21 ->
      IO.puts "you are cleared to enter the foo bar, #{person.name}"

    _ ->
      IO.puts "sorry, no admission"
  end
end
