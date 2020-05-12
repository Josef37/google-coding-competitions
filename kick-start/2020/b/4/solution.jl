function solve()
  t = parse(Int, readline())

  for x in 1:t
    w,h,l,u,r,d = tointarray(readline())
    y = solve_case(w,h,l,u,r,d)
    println("Case #$x: $y")
  end
end

function solve_case(w,h,l,u,r,d)
  if (l == 1 && r == w) || (u == 1 && d == h) || (l == 1 && u == 1)
    return 0
  end

  prob = BigFloat(0)

  y = d
  for x in 1:l-1
    prob += 0.5 * getprob(x,y)
  end

  x = r
  for y in 1:u-1
    prob += 0.5 * getprob(x,y)
  end

  return prob
end

function getprob(x,y)
  x -= 1
  y -= 1
  return binomial(x+y,x) * 0.5^(x+y)
end

function tointarray(string) 
  return map(n -> parse(BigInt, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
