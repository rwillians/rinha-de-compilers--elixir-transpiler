defmodule Parser.BinaryOp do
  @moduledoc false

  @typedoc false
  @type t :: %Parser.BinaryOp{
          lhs: Parser.expr(),
          op: :eq | :ne | :lt | :gt | :lte | :gte | :add | :sub | :mult | :div | :or,
          rhs: Parser.expr(),
          location: Parser.Location.t()
        }
  defstruct [:lhs, :op, :rhs, :location]
end

defimpl Transpiler.Node, for: Parser.BinaryOp do
  def transpile(%{op: :lt} = node, mod) do
    {:<, [context: mod, imports: [{1, Kernel}, {2, Kernel}]],
     [
       Transpiler.Node.transpile(node.lhs, mod),
       Transpiler.Node.transpile(node.rhs, mod)
     ]}
  end

  def transpile(%{op: :add} = node, mod) do
    {:+, [context: mod, imports: [{1, Kernel}, {2, Kernel}]],
     [
       Transpiler.Node.transpile(node.lhs, mod),
       Transpiler.Node.transpile(node.rhs, mod)
     ]}
  end

  def transpile(%{op: :sub} = node, mod) do
    {:-, [context: mod, imports: [{1, Kernel}, {2, Kernel}]],
     [
       Transpiler.Node.transpile(node.lhs, mod),
       Transpiler.Node.transpile(node.rhs, mod)
     ]}
  end

  def transpile(%{op: :eq} = node, mod) do
    {:==, [context: mod, imports: [{2, Kernel}]],
     [
       Transpiler.Node.transpile(node.lhs, mod),
       Transpiler.Node.transpile(node.rhs, mod)
     ]}
  end

  def transpile(%{op: :or} = node, mod) do
    {:or, [context: mod, imports: [{2, Kernel}]],
     [
       Transpiler.Node.transpile(node.lhs, mod),
       Transpiler.Node.transpile(node.rhs, mod)
     ]}
  end
end
