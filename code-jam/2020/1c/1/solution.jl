using LinearAlgebra

function solve()
  t = parse(Int, readline())

  for i in 1:t
    x,y,m = split(readline())
    x,y = parse(Int,x), parse(Int,y)
    sol = solve_case(x,y,m)
    println("Case #$i: $sol")
  end
end

function solve_case(x,y,m)
  # Same spot in the beginning
  if x == y == 0
    return 0
  end

  # How far is he each step
  for (t, dir) in enumerate(m)
    x,y = move(x,y,dir)
    dist = distance(x,y)
    if dist <= t
      return t
    end
  end

  return "IMPOSSIBLE"
end

function distance(x,y)
  return abs(x) + abs(y)
end

function move(x,y,dir)
  if dir == 'N'
    return x,y+1
  elseif dir == 'E'
    return x+1,y
  elseif dir == 'S'
    return x,y-1
  elseif dir == 'W'
    return x-1,y
  else
    throw("Invalid direction")
  end
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
