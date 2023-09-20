defmodule AST.BinaryOp.Gt do
  @moduledoc false

  @typedoc false
  @type t :: %AST.BinaryOp.Gt{
          lhs: AST.ast_term(),
          rhs: AST.ast_term(),
          location: AST.Location.t()
        }
  defstruct [:lhs, :rhs, :location]
end

defimpl Transpilable, for: AST.BinaryOp.Gt do
  def to_elixir_ast(ast, env) do
    {:>,
     [
       context: env,
       imports: [{2, Kernel}],
       file: ast.location.filename,
       line: ast.location.start.line
     ],
     [
       Transpilable.to_elixir_ast(ast.lhs, env),
       Transpilable.to_elixir_ast(ast.rhs, env)
     ]}
  end
end
