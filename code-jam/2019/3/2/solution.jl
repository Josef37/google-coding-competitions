function solve()
  t = parse(Int, readline())

  for x in 1:t
    s = parse(Int, readline())
    ps = tointarray(readline())
    y = solve_case(s, ps) % (10^9 + 7)
    println("Case #$x: $y")
  end
end

function solve_naive(s, ps)
  cost = 0
  for l in 1:s-2
    for r in l+2:s
      cost = (cost + getcost(ps[l:r])) % (10^9 + 7)
    end
  end
  return cost
end

function solve_case(s, ps)
  costs = fill(0, s, s)
  totalcosts = 0
  for len in 3:s
    for left in 1:s-len+1
      right = left + len - 1
      # todo: precompute maximum
      maxindex = argmax(ps[left:right]) + left - 1
      if maxindex in [left, right]
        costs[left,right] = getcost(ps[left:right])
      else
        costs[left,right] = costs[left,maxindex] + costs[maxindex,right]
      end
      totalcosts = (totalcosts + costs[left, right]) % (10^9 +7)
    end
  end
  return totalcosts
end

function getcost(ps)
  function pyramidify(ps)
    ps = copy(ps)
    for i in 2:length(ps)
      if ps[i] < ps[i-1]
        ps[i] = ps[i-1]
      end
    end
    return ps
  end

  value, maxindex = findmax(ps)
  cost = sum(append!(pyramidify(ps[1:maxindex]), reverse!(pyramidify(reverse!(ps[maxindex+1:end])))) - ps)
  return cost
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
