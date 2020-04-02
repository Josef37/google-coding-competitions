function solve()
  t = parse(Int, readline())

  for x in 1:t
    r,c = tointarray(readline())
    grid = Array{Char,2}(undef,r,c)
    for i in 1:r
      grid[i, :] = readline()
    end
    y = solve_case(r,c,grid)
    println("Case #$x: $y")
  end
end

function solve_case(r,c,grid)

end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
