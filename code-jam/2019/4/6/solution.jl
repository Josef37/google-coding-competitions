using Base.Iterators

const directions = Dict(
  'N' => [-1, 0],
  'E' => [ 0, 1],
  'S' => [ 1, 0],
  'W' => [ 0,-1],
)

function solve()
  t = parse(Int, readline())

  for x in 1:t
    r, c = tointarray(readline())
    isdanger = fill(false,r,c)
    start = [-1,-1]
    target = [-1,-1]
    for i in 1:r, (j,char) in enumerate(readline())
      if char == '#'
        isdanger[i,j] = true
      elseif char == 'M'
        start = [i,j]
      elseif char == 'N'
        target = [i,j]
      end
    end
    y = solve_case(r, c, start, target, isdanger)
    println("Case #$x: $y")
  end
end

function solve_case(r, c, start, target, isdanger)
  # Using "goto" to jump forwards has no use? Just shift the loop
  # 1:N, 2:W, 3:G(6), 4:W, 5:N, 6:N, 7:E, 8:G(4) -> NW NE WNNE WNNE ...
  # 1:N, 2:W, 3:N, 4:E, 5:W, 6:N, 7:G(3) -> NWNEWN NEWN NEWN ...
  
  # When going backwards without jumping another goto statement, an inifite loop is entered
  # Either you don't loop at all, or you do it inifitely
  # Jumping another "goto" has no use, just reorder things

  # Does doing the same thing in the same position ever make sense?
  # Since it is just once or inifitely, it makes no sense...

  # Step 1: calculate all distances

  # Step 2: find patterns for ending the search
  # You don't have to make full cycles. You could hit the target anytime.
  # Pick a pattern, do it backwards until in danger and save the minimum
  # A pattern can undo its own moves to get to the target

  distances = getdistances(start, isdanger)
  y = distances[target...]
  if y > r*c 
    return "IMPOSSIBLE"
  end

  # IMPROVE HERE: Don't try all possible cycles
  # Try all displacement vectors and number of cycles
  cyclelength = 1
  while cyclelength < y
    for c in getcycles(cyclelength, target, isdanger)
      current = copy(target)
      for step in cycle(c)
        current += step
        if !all([1,1] .<= current .<= size(isdanger)) || isdanger[current...]
          break
        end
        y = min(y, cyclelength + 1 + distances[current...])
      end
    end
    cyclelength += 1
  end

  return y
end

function getcycles(cyclelength, from, isdanger)
  cycles = []
  active = [(from, [])]
  while !isempty(active)
    current, path = popfirst!(active)
    if length(path) == cyclelength
      if current != from 
        push!(cycles, path)
      end
      continue
    end
    for neighbor in getsafeneighbors(current, isdanger)
      push!(active, (neighbor, push!(copy(path), neighbor - current)))
    end
  end
  return cycles
end

function getdistances(from, isdanger)
  distances = fill(typemax(Int), size(isdanger))
  active = [(from, 0)]
  visited = Set()
  while !isempty(active)
    current, distance = popfirst!(active)
    if current in visited 
      continue 
    end
    push!(visited, current)
    distances[current...] = distance
    for neighbor in getsafeneighbors(current, isdanger)
      push!(active, (neighbor, distance+1))
    end
  end
  return distances
end

function getsafeneighbors((row,col), isdanger)
  r,c = size(isdanger)
  safeneighbors = []
  for (dr, dc) in values(directions)
    if (1 <= row+dr <= r) && (1 <= col+dc <= c) && !isdanger[row+dr, col+dc]
      push!(safeneighbors, [row+dr, col+dc])
    end
  end
  return safeneighbors
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
