using JuMP, GLPK

function solve()
  t = parse(Int, readline())

  for x in 1:t
    n,k = tointarray(readline())
    ys = solve_case(n,k)
    if isempty(ys)
      println("Case #$x: IMPOSSIBLE")
    else
      println("Case #$x: POSSIBLE")
      for row in eachrow(ys)
        println(join(row, " "))
      end
    end
  end
end

function solve_case(n,trace)
  model = Model(GLPK.Optimizer)

  # number at row i, column j is k?
  @variable(model, x[i=1:n, j=1:n, k=1:n], Bin)

  # only one number per cell
  for i=1:n, j=1:n
    @constraint(model, sum(x[i,j,k] for k=1:n) == 1)
  end
  # each number once in rows and columns
  for index=1:n, k=1:n
    @constraint(model, sum(x[index,j,k] for j=1:n) == 1)
    @constraint(model, sum(x[i,index,k] for i=1:n) == 1)
  end
  # diagonal sum
  @constraint(model, sum(collect(1:n)' * x[i,i,:] for i in 1:n) == trace)

  @objective(model, MOI.FEASIBILITY_SENSE, 0)

  optimize!(model)

  if(termination_status(model) == MOI.INFEASIBLE)
    return []
  end
  solution = fill(0, n, n)
  result = value.(x)
  for i in 1:n, j in 1:n
    solution[i,j] = findfirst(x -> x > 0.5, result[i,j,:])
  end
  return solution
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
