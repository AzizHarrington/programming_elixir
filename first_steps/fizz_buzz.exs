fizz_buzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, arg -> arg
end

five_and_three = fn
  n -> fizz_buzz.(rem(n, 3), rem(n, 5), n)
end

IO.puts five_and_three.(10)
IO.puts five_and_three.(11)
IO.puts five_and_three.(12)
IO.puts five_and_three.(13)
IO.puts five_and_three.(14)
IO.puts five_and_three.(15)
IO.puts five_and_three.(16)
