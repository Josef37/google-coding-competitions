function solve()
  t = parse(Int, readline())

  for x in 1:t
    n, b = tointarray(readline())
    as = tointarray(readline())
    y = solve_case(n, b, as)
    println("Case #$x: $y")
  end
end

function solve_case(n, b, as)
  @assert n == length(as)

  sort!(as)
  y = 0
  sum_a = 0
  for a in as
    if sum_a + a > b 
      break 
    end
    y += 1
    sum_a += a
  end
  return y
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end

function generator() 
  str = "100\n"
  for i in 1:100
    str *= "100 3000\n" 
    str *= join(map(_ -> rand(1:100), 1:100), ' ') * "\n"
  end
  write("test2.in", str)
end