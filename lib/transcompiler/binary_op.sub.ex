defmodule Transcompiler.BinaryOp.Sub do
  @moduledoc false

  @typedoc false
  @type t :: %Transcompiler.BinaryOp.Sub{
          lhs: Transcompiler.Term.t(),
          rhs: Transcompiler.Term.t(),
          location: Transcompiler.Location.t() | nil
        }
  defstruct [:lhs, :rhs, location: nil]
end

defimpl Transcompiler.Transpiler, for: Transcompiler.BinaryOp.Sub do
  def to_elixir_ast(ast, env) do
    {:-, [context: env, imports: [{2, Kernel}]], [
      Transcompiler.Transpiler.to_elixir_ast(ast.lhs, env),
      Transcompiler.Transpiler.to_elixir_ast(ast.rhs, env),
    ]}
  end
end
