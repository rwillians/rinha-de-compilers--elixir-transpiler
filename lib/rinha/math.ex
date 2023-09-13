defmodule Rinha.Math do
  use Transcompiler,
    parser: Rinha.Parser,
    source: """
    let add = fn (a, b) => { a + b };
    let sub = fn (a, b) => { a - b };
    let mul = fn (a, b) => { a * b };
    let div = fn (a, b) => { a / b };
    """
end
