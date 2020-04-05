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
  elements = findtrace(n, trace)
  if isempty(elements)
    return []
  end

  square = buildsquare(n,elements)

  return square
end

function buildsquare(n,elements)
  
end

function findtrace(n,trace)
  # find a possible sum for trace
  avg = round(Int, trace / n)
  for main in max(1,avg-1):min(n,avg+1)
    elements = repeat([main], n-2)
    remainder = trace - sum(elements)
    for x in 1:remainder-1
      y = remainder - x
      if (1 <= x <= n) && (1 <= y <= n) && ((x == y == main) || (main != x && main != y && (n > 3 || x != y))) 
        push!(elements, x, y)
        return elements
      end
    end
  end
  return []
end

function hastrace(n, square, trace)
  if n == 0
    return trace == 0
  end
  return any(i -> hastrace(n-1, square[1:end .!= i ,2:end], trace - square[i, 1]), 1:n)
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
