function solve()
  t = parse(Int, readline())

  for x in 1:t
    n = parse(Int, readline())
    hs = tointarray(readline())
    y = solve_case(n,hs)
    println("Case #$x: $y")
  end
end

function solve_case(n,hs)
  return count(((p,c,n),) -> p < c > n, zip(hs[1:end-2], hs[2:end-1], hs[3:end]))
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
