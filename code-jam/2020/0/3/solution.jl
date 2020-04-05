function solve()
  t = parse(Int, readline())

  for x in 1:t
    n = parse(Int, readline())
    intervals = [tointarray(readline()) for i in 1:n]
    y = solve_case(n, intervals)
    println("Case #$x: $y")
  end
end

function solve_case(n, intervals)
  overlapping = Dict{Int,Array{Int}}()

  sortedstartsperm = sortperm(map(first, intervals))
  sortedstarts = map(first, intervals)[sortedstartsperm]

  for (i, (s,e)) in enumerate(intervals)
    firststart = searchsortedfirst(sortedstarts, s)
    laststart = searchsortedfirst(sortedstarts, e) - 1
    for j in firststart:laststart
      i_ = sortedstartsperm[j]
      if i == i_ continue end
      overlapping[i] = push!(get(overlapping, i, []), i_)
      overlapping[i_] = push!(get(overlapping, i_, []), i)
    end
  end

  @debug overlapping

  colors = fill(' ', n)
  tocolor = Set()
  while true
    firstuncolored = findfirst(c -> c == ' ', colors)
    if !isnothing(firstuncolored)
      push!(tocolor, (firstuncolored, 'C'))
    else
      break
    end

    while !isempty(tocolor)
      index, color = pop!(tocolor)
      if colors[index] == color 
        continue
      elseif colors[index] == ' '
        colors[index] = color
        for i in get(overlapping, index, [])
          push!(tocolor, (i, color == 'C' ? 'J' : 'C'))
        end
      else
        return "IMPOSSIBLE"
      end
    end
  end

  return join(colors)
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
