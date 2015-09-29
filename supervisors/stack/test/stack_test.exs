defmodule StackTest do
  use ExUnit.Case, async: true

  setup do
    Application.stop :stack
    Application.start :stack
  end

  test "stack initialized with defaults" do
    {state, _pid} = :sys.get_state Stack.Server
    assert state == [1,2,3,4,5]
  end

  test "pop from stack" do
    item = Stack.Server.pop
    assert item == 1
  end

  test "pop from empty stack" do
    for _ <- 1..5, do: Stack.Server.pop
    catch_exit Stack.Server.pop
  end

  test "push to stack" do
    Stack.Server.push 'hello'
    assert Stack.Server.pop == 'hello'
  end
end
