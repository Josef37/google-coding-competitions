function solve()
  t = parse(Int, readline())

  for x in 1:t
    n = parse(Int, readline())
    ms = Array{Int,2}(undef, n, n)
    for i in 1:n
      ms[i, :] = tointarray(readline())
    end
    k,r,c = solve_case(n, ms)
    println("Case #$x: $k $r $c")
  end
end

function solve_case(n, ms)
  k = sum([ms[i,i] for i in 1:n])
  r = 0
  for i in 1:n
    isfound = fill(false, n)
    for j in 1:n
      if isfound[ms[i,j]] 
        r += 1
        break
      end
      isfound[ms[i,j]] = true
    end
  end

  c = 0
  for i in 1:n
    isfound = fill(false, n)
    for j in 1:n
      if isfound[ms[j,i]] 
        c += 1
        break
      end
      isfound[ms[j,i]] = true
    end
  end

  return k, r, c
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
