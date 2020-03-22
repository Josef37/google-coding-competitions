function solve()
  t = parse(Int, readline())

  for x in 1:t
    n, k, p = tointarray(readline())
    vs = Array{Int, 2}(undef, n, k)
    for i in 1:n
      vs[i, :] = tointarray(readline())
    end
    y = solve_brute(n, k, p, vs)
    # y_ = solve_case(n, k, p, vs)
    # if y != y_
    #   println("Case #$x: $y $y_")
    # end
    println("Case #$x: $y")
  end
end

function solve_brute(n, k, p, vs)
  function brute(i, p)
    if i > n || p == 0
      return 0 
    elseif table[i, p] != -1
      return table[i, p]
    end
    v = vs[i, :]
    score = 0
    for j in 0:min(p,k)
      b = sum(v[1:j])
      score = max(score, b + brute(i+1, p-j))
    end
    table[i, p] = score
    return score
  end

  table = fill(-1, (n, p))
  return brute(1, p)
end

function solve_case(n, k, p, vs)
  beautyscore = Rational(0)
  ds = density(vs)

  while p > 0
    @debug "" vs
    @debug "" map(Float64, ds)

    maxd, pos = findmax(ds[:, 1:min(p,k)])
    i, j = Tuple(pos)
    beautyscore += maxd * j
    p -= j
    vs[i, 1:k-j] = vs[i, j+1:k]
    vs[i, k-j+1:k] .= -1
    ds[i:i, :] = density(vs[i:i, :])
  end

  @debug "" vs
  @debug "" map(Float64, ds)

  @assert isinteger(beautyscore)
  return round(Int, beautyscore)
end

function density(vs) 
  ds = Array{Rational, 2}(undef, size(vs))
  for i in 1:size(ds, 1)
    sum = 0
    for j in 1:size(ds, 2)
      sum += vs[i, j]
      ds[i, j] = sum // j
    end
  end
  return ds
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

function generate(t, maxn, maxk=30, maxb=100)
  str = "$t\n"
  for _ in 1:t 
    n = rand(1:maxn)
    k = rand(1:maxk)
    p = rand(1:n*k)
    str *= "$n $k $p\n"
    for _ in 1:n
      str *= join(map(_ -> rand(1:maxb), 1:k), ' ') * "\n"
    end
  end
  write("test2.in", str)
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
