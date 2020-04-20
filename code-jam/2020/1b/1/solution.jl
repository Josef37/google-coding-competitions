function solve()
  t = parse(Int, readline())

  for x in 1:t
    x_,y_ = tointarray(readline())
    y = solve_case(x_,y_)
    println("Case #$x: $y")
  end
end

function solve_case(x,y)
  solution = solve_helper(x,y)
  if solution[end] == 'X'
    return "IMPOSSIBLE"
  else
    return solution
  end
end

function solve_helper(x,y)
  @debug "$x $y"
  if isodd(x) && iseven(y)
    if abs(x) == 1 && y == 0
      return x == 1 ? 'E' : 'W'
    elseif isodd((x+1) ÷ 2) ⊻ isodd(y ÷ 2)
      return 'W' * solve_helper((x+1) ÷ 2, y ÷ 2)
    else
      return 'E' * solve_helper((x-1) ÷ 2, y ÷ 2)
    end
  elseif iseven(x) && isodd(y)
    if x == 0 && abs(y) == 1
      return y == 1 ? 'N' : 'S'
    elseif isodd(x ÷ 2) ⊻ isodd((y+1) ÷ 2)
      return 'S' * solve_helper(x ÷ 2, (y+1) ÷ 2)
    else
      return 'N' * solve_helper(x ÷ 2, (y-1) ÷ 2)
    end
  else
    return 'X'
  end
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
