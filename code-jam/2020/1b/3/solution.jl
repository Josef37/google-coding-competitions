function solve()
  t = parse(Int, readline())

  for x in 1:t
    _ = tointarray(readline())
    y = solve_case()
    println("Case #$x: $y")
  end
end

function solve_case()

end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
