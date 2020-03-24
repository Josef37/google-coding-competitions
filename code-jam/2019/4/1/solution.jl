function solve()
   t, n_max, m, r = tointarray(readline())

  for x in 1:t
    solve_case(n_max, m, r)
  end
end

# IMPROVE HERE: You can't fully determine the positions
# But you can always calculate all distances
# Go from (2M,0) to (2M,K) to better determine the diagonals
# And maybe transfrom coordinates to diagonals
function solve_case(n_max, m, r)
  println("$(m+1) $(m+1)")
  d_out = parse(Int, readline())
  println("$m $m")
  d = parse(Int, readline())
  n = d_out - d
  @assert n <= n_max
  
  for _ in 3:r
    # Send "A B", receive count
  end

  println("READY")

  for _ in 1:r
    line = readline()
    if line == "DONE" break end
    if line == "ERROR" exit(1) end
    c, d = tointarray(line)
    # Receive "C D", send count
  end
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
