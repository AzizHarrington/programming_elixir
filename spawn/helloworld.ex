defmodule HelloWorld do
  def greet do
    receive do
      {sender, msg} ->
        send sender, { :ok, "Hello, #{msg}"}
        greet
    end
  end
end

# client
pid = spawn(HelloWorld, :greet, [])
send pid, {self, "World!"}

receive do
  {:ok, message} ->
    IO.puts message
end

send pid, {self, "kermit"}
receive do
  {:ok, message} ->
    IO.puts message
  after 500 ->
    IO.puts "the greeter process has gone away"
end
