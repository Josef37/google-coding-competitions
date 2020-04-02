function solve()
  t = parse(Int, readline())

  for x in 1:t
    n,k = tointarray(readline())
    ps = [tointarray(readline()) for _ in 1:n]
    y = solve_case(n,k,ps)
    if isempty(y)
      println("Case #$x: IMPOSSIBLE")
    else
      println("Case #$x: POSSIBLE")
      for seg in y println(seg) end
    end
  end
end

function solve_case(n,k,ps)

end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
