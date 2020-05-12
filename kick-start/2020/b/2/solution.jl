function solve()
  t = parse(Int, readline())

  for x in 1:t
    n,d = tointarray(readline())
    xs = tointarray(readline())
    y = solve_case(n,d,xs)
    println("Case #$x: $y")
  end
end

function solve_case(n,d,xs)
  for x in Iterators.reverse(xs)
    d -= d % x
  end
  return d
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
