function solve()
  t, w = tointarray(readline())

  for x in 1:t
    solve_case()
  end
end

function solve_case()
  while true
    move = parse(Int, readline())
    if move < 0
      @debug "Ended with $move"
      return
    end

  end 
end

function getmovebounds(intervallength)
  upper = intervallength ÷ 10^10
  lower = upper <= 1 ? upper : intervallength ÷ (2*10^10 - 1)
  return lower, upper
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
