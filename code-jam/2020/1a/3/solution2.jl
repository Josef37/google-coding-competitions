function solve()
  t = parse(Int, readline())

  for x in 1:t
    r,c = tointarray(readline())
    ss = fill(0, r, c)
    for i in 1:r
      ss[i, :] = tointarray(readline())
    end
    y = solve_case(r,c,ss)
    println("Case #$x: $y")
  end
end

function solve_case(r,c,ss)
  interest = lastsum = sum(ss)
  while true
    delta, ss = simulate(r,c,ss)

    if delta == 0 
      return interest      
    end

    lastsum -= delta
    interest += lastsum
  end
end

function simulate(r,c,ss)
  new_ss = copy(ss)
  delta = 0

  for i in 1:r, j in 1:c
    skill = ss[i,j]
    if skill == 0
      continue
    end
    neighboravg = getneighboravg(r,c,ss,i,j)
    if skill < neighboravg
      new_ss[i,j] = 0
      delta += skill
    end
  end

  return delta, new_ss
end

function getneighboravg(r,c,ss,i,j)
  neigborskills = fill(0, 4)

  north = findlast(s -> s > 0, ss[1:i-1, j])
  neigborskills[1] = isnothing(north) ? 0 : ss[1:i-1, j][north]

  east = findfirst(s -> s > 0, ss[i, j+1:end])
  neigborskills[2] = isnothing(east) ? 0 : ss[i, j+1:end][east]

  south = findfirst(s -> s > 0, ss[i+1:end, j])
  neigborskills[3] = isnothing(south) ? 0 : ss[i+1:end, j][south]

  west = findlast(s -> s > 0, ss[i, 1:j-1])
  neigborskills[4] = isnothing(west) ? 0 : ss[i, 1:j-1][west]

  return sum(neigborskills) / count(s -> s > 0, neigborskills)
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
