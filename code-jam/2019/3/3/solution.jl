function solve()
  t = parse(Int, readline())

  for x in 1:t
    r,c = tointarray(readline())
    ms = Array{Char,2}(undef,r,c)
    for i in 1:r
      ms[r, :] = readline()
    end
    y = solve_case(r,c,ms)
    if isempty(y)
      println("Case #$x: IMPOSSIBLE")
    else
      println("Case #$x: POSSIBLE")
      println(y)
    end
  end
end

function solve_case(r,c,ms)

end

function buildgraph(r,c,ms)
  groups = fill(0,r,c)
  for i in 1:r, j in 1:c
    
  end
end

function getgroupmembers(i,j,r,c,ms)
  nodes = [[i,j]]
  char = ms[i,j]
  groupmembers = []
  while !isempty(nodes)
    i,j = pop!(nodes)
    push!(groupmembers, [i,j])
    neighbours = getneighbours(i,j,r,c)
    push!(nodes, filter(n -> ms[n...] == char && !(n in nodes), neighbours)...)
  end
  return groupmembers
end

function getneighbours(i,j,r,c)
  neighbours = []
  if i > 1 push!(neighbours, [i-1,j]) end
  if i < r push!(neighbours, [i+1,j]) end
  if j > 1 push!(neighbours, [i,j-1]) end
  if j < c push!(neighbours, [i,j+1]) end
  return neighbours
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
