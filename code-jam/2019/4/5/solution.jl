function solve()
  t = parse(Int, readline())

  for x in 1:t
    n = parse(Int, readline())
    ps = [tointarray(readline()) for _ in 1:n]
    y = solve_case(n, ps)
    println("Case #$x: $y")
  end
end

function solve_case(n, ps)
  
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
