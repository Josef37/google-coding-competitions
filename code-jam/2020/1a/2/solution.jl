function solve()
  t = parse(Int, readline())

  for x in 1:t
    n = parse(Int, readline())
    y = solve_case(n)
    println("Case #$x:")
    for (r, k) in y
      println("$r $k")
    end
  end
end

function solve_case(n)
  #=
    the sum of the r-th row is 2^(r-1)
    try to combine a number as binary
    but every row has to be visited (so it is at least 1)
  =#

  r_min = floor(Int, log2(n)) + 1
  rows = []
  r = r_min
  for outer r in r_min:500
    rows = getrows(n-r, r)
    if !isempty(rows)
      break
    end
  end

  return getpath(r, rows)
end

function getrows(n, r_max)
  rs = []
  for r in r_max:-1:1
    x = 2^(r-1)-1
    if n >= x
      push!(rs, r)
      n -= x
    end
  end

  if n > 0
    return []
  end

  return rs
end

function getpath(max_r, rows)
  left = true
  path = []
  for r in 1:max_r
    if r in rows
      append!(path, [(r,k) for k in (left ? (1:r) : (r:-1:1))])
      left = !left
    else
      push!(path, (r,left ? 1 : r))
    end
  end
  return path
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
