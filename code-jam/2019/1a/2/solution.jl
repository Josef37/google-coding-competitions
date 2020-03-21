function solve()
  t, n, m = tointarray(readline())

  for x in 1:t
    y = solve_case(n,m)
    println(y)
    if parse(Int, readline()) != 1 break end
  end
end

function solve_case(n,m)
  divisors = [5,7,9,11,13,16,17]
  @assert n >= length(divisors)
  sieve = Set(1:m)
  for p in divisors
    repeat([p], 18) |> s->join(s, ' ') |> println
    g0 = tointarray(readline()) |> sum
    gs = Set(g0:p:m)
    intersect!(sieve, gs)
  end
  @assert (length(sieve) == 1) repr(sieve)
  return pop!(sieve)
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end