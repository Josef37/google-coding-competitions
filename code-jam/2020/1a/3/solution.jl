struct Cell
  index::Tuple{Int,Int}
  skill::Int
  neighbors::Array{Union{Cell,Nothing},1}
end

north(cell::Cell) = cell.neighbors[1]
east(cell::Cell) = cell.neighbors[2]
south(cell::Cell) = cell.neighbors[3]
west(cell::Cell) = cell.neighbors[4]
getneighbors(cell::Cell) = filter(!isnothing, cell.neighbors)

function islosing(cell::Cell)
  neighbors = getneighbors(cell)
  avgskill = sum(map(neigbour -> neigbour.skill, neighbors)) / length(neighbors)
  return cell.skill < avgskill
end

function showcell(cell::Cell)
  ns = getneighbors(cell)
  ns = map(n -> n.index, ns)
  return repr(cell.index) * " " * repr(ns)
end

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
  cells = parseinput(r,c,ss)
  
  # mark losing cells
  roundinterest = sum(cell -> cell.skill, cells)
  losingcells = Set(filter(islosing, cells))

  interest = roundinterest
  
  while true
    if isempty(losingcells)
      break
    end

    # remove them and pass their neighbors to their neighbors (mark as altered)
    alteredcells, interestdelta = removecells(losingcells)

    roundinterest -= interestdelta
    interest += roundinterest

    # check altered cells if losing -> mark them
    losingcells = Set(filter(islosing, alteredcells))
  end

  return interest
end

function removecells(losingcells)
  alteredcells = Set()
  interestdelta = 0
  for cell in losingcells
    interestdelta += cell.skill
    removecell(cell, losingcells, alteredcells)
  end
  return alteredcells, interestdelta
end

function removecell(cell, losingcells, alteredcells)
  for (i, neighbor) in enumerate(cell.neighbors)
    if isnothing(neighbor)
      continue 
    end
    oppositedirection = (i+1)%4 + 1
    neighbor.neighbors[oppositedirection] = cell.neighbors[oppositedirection]
    if !(neighbor in losingcells)
      push!(alteredcells, neighbor)
    end
  end
end

function parseinput(r,c,ss)
  cells = Array{Union{Nothing,Cell},2}(nothing, r, c)
  for i in 1:r, j in 1:c
    cells[i,j] = Cell((i,j), ss[i,j], fill(nothing, 4))
  end
  for i in 1:r, j in 1:c
    cells[i,j].neighbors[1] = i-1 < 1 ? nothing : cells[i-1, j]
    cells[i,j].neighbors[2] = j+1 > c ? nothing : cells[i, j+1]
    cells[i,j].neighbors[3] = i+1 > r ? nothing : cells[i+1, j]
    cells[i,j].neighbors[4] = j-1 < 1 ? nothing : cells[i, j-1]
  end

  return cells
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
