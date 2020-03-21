function solve()
  t = parse(Int, readline())

  for x in 1:t
    r, c = tointarray(readline())
    path = solve_case(r,c)
    @debug "r:$r c:$c"
    if isempty(path)
      println("Case #$x: IMPOSSIBLE")
    else
      println("Case #$x: POSSIBLE")
      println(join(map(t -> join(t, ' '), path), '\n'))
    end
  end
end

function solve_case(r,c)
  unvisited = Set(collect(Iterators.product(1:r, 1:c)))
  solution_path = []
  solve_rec(r,c,unvisited,nothing,[],solution_path)
  return solution_path
end

function solve_rec(r,c,unvisited,last,path,solution)
  if isempty(unvisited) 
    append!(solution, path)
    return true
  end

  possible = false
  for cell in unvisited
    if !ispossible(last, cell)
      continue
    end
    delete!(unvisited, cell)
    push!(path,cell)
    possible = possible || solve_rec(r,c,unvisited,cell,path,solution)
    pop!(path)
    push!(unvisited, cell)
  end
  return possible
end

function ispossible(pos1, pos2) 
  if isnothing(pos1) || isnothing(pos2) 
    return true 
  end
  return pos1[1] != pos2[1] &&
    pos1[2] != pos2[2] &&
    pos1[1] + pos1[2] != pos2[1] + pos2[2] &&
    pos1[1] - pos1[2] != pos2[1] - pos2[2]
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end

function generate(r, c) 
  A = collect(Iterators.product(1:r, 1:c))
  write("test.in", "$(length(A))\n" * join(map(t -> join(t, ' '), A), '\n'))
end