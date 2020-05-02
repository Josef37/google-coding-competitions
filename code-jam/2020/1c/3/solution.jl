function solve()
  t = parse(Int, readline())

  for x in 1:t
    n,d = tointarray(readline())
    as = tointarray(readline())
    y = solve_case(n,d,as)
    println("Case #$x: $y")
  end
end

function solve_case(n,d,as)
  sizecounts = Dict{Int,Int}()
  for a in as
    sizecounts[a] = 1 + get(sizecounts, a, 0)
  end

  if d == 2
    if any(x -> x >= 2, values(sizecounts))
      return 0
    else
      return 1
    end
  else
    best = 2
    for (a, n) in sizecounts
      if n >= 3
        return 0
      elseif n == 2
        if any(a_ -> a_ > a, keys(sizecounts))
          best = 1
        end
      else
        if get(sizecounts, a*2, 0) >= 1
          best = 1
        end
        if iseven(a) && get(sizecounts, a÷2, 0) >= 1
          best = 1
        end
      end
    end
    return best
  end
end

function generate(t = 1, max_n = 300, max_d = 50)
  str = "$t\n"
  for i in 1:t
    n = rand(1:max_n)
    d = rand(1:max_d)
    str *= "$n $d\n"
    as = [rand(1:100) for _=1:n]
    str *= join(as, " ") * "\n"
  end
  write("testgen.in", str)
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
