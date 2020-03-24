function solve()
  t, w = tointarray(readline())

  for x in 1:t
    rs = solve_case(w)
    println(join(rs, ' '))
    if parse(Int, readline()) == -1 break end
  end
end

function solve_case(w)
  @assert w >= 2

  rs = fill(0, 6)

  day = 220
  factors = getfactors(day)
  println(day)
  answer = parse(Int, readline())
  rs[4:6] = (answer .÷ factors[4:6]) .% 2^7

  day = 56
  factors = getfactors(day)
  println(day)
  answer = parse(Int, readline())
  answer -= factors[4:6]' * rs[4:6] 
  rs[1:3] = (answer .÷ factors[1:3]) .% 2^7

  return rs
end

function getfactors(day) 
  2 .^ (day .÷ (1:6))
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
