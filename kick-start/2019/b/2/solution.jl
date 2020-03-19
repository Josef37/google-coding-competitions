using Printf

struct Stone
  time::Int
  energy::Int
  lossrate::Int
end

function solve() 
  t = parse(Int, readline())

  for x in 1:t
    n = parse(Int, readline())
    stones = []
    for i in 1:n
      push!(stones, Stone(to_int_array(readline())...))
    end

    y = max_energy(stones)
    @printf("Case #%d: %d\n", x, y)
  end
end

function max_energy(stones) 
  sort!(stones; by=s->s.time/s.lossrate)
  @debug repr(stones)
  max_time = sum(s->s.time, stones)
  table = Array{Union{Nothing, Int}}(nothing, max_time+1, length(stones))
  return stone_knapsack(stones, table, 0, 1)
end

# How much energy can you get by eating stones up to index at the starting time
function stone_knapsack(sorted_stones, table, time, index) 
  if index > length(sorted_stones)
    return 0 
  end

  if !isnothing(table[time+1, index])
    @debug "hit"
    return table[time+1, index]
  end
  
  stone = sorted_stones[index]
  optimum = max(
    stone_knapsack(sorted_stones, table, time + stone.time, index+1) + stone.energy - time*stone.lossrate, # take the stone
    stone_knapsack(sorted_stones, table, time, index+1) # don't take it
  )
  table[time+1, index] = optimum
  return optimum
end

function to_int_array(string) 
  return map(n -> parse(Int, n), split(string))
end

solve()