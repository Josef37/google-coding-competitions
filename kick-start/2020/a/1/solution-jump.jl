using JuMP
using GLPK

function solve()
  t = parse(Int, readline())

  for x in 1:t
    n, b = tointarray(readline())
    as = tointarray(readline())
    y = solve_case(n, b, as)
    println("Case #$x: $y")
  end
end

function solve_case(n, b, as)
  model = Model(GLPK.Optimizer)
  @variable(model, x[1:length(as)], Bin)
  @objective(model, Max, sum(x))
  @constraint(model, con, sum(as .* x) <= b)
  optimize!(model)
  return floor(Int, objective_value(model))
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
