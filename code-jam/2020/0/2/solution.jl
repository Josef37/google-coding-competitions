function solve()
  t = parse(Int, readline())

  for x in 1:t
    s = map(n -> parse(Int, n), split(readline(), ""))
    y = solve_case(s)
    println("Case #$x: $y")
  end
end

function solve_case(s)
  pushfirst!(s, 0)
  push!(s,0)
  s_ = ""
  for i in 2:length(s)
    prev = s[i-1]
    cur = s[i]
    s_ *= getParentheses(prev, cur) * string(cur)
  end
  return s_[1:end-1]
end

function getParentheses(prev, cur)
  if prev < cur
    return repeat("(", cur - prev)
  else
    return repeat(")", prev - cur)
  end
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
