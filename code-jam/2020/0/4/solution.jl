import Base.!

!(x::Nothing) = x

function solve()
  t, b = tointarray(readline())

  for x in 1:t
    y = solve_case(b)
    println(y)
    if readline() != "Y"
      exit(1)
    end
  end
end

function solve_case(b)
  known = Array{Union{Bool,Nothing}}(nothing,b)
  querycount = 0
  nextbit = 1
  equalpair = nothing
  distinctpair = nothing
  while true
    while querycount % 10 != 0 || querycount == 0
      println(nextbit)
      known[nextbit] = parse(Int, readline())

      if isnothing(equalpair) && known[nextbit] == known[b+1-nextbit] && nextbit > b ÷ 2
        equalpair = nextbit
        # println(stderr, "Found equal pair $equalpair")
      end
      if isnothing(distinctpair) && known[nextbit] != known[b+1-nextbit] && nextbit > b ÷ 2
        distinctpair = nextbit
        # println(stderr, "Found distinct pair $distinctpair")
      end

      # # println(stderr, "Quering $nextbit with query $querycount")
      # # println(stderr, "Received $(known[nextbit])")
      # flush(stderr)
      # # println(stderr, join(map(x -> isnothing(x) ? 'X' : x ? '1' : '0', known)))

      nextbit = getnextbit(nextbit, b)
      querycount += 1
      if !(nothing in known)
        return join(map(Int, known))
      end
    end

    if isnothing(equalpair)
      println(distinctpair)
      readline()
      println(distinctpair) # keep querycount even
      newbit = parse(Int, readline())
      if newbit != known[distinctpair]
        known = .!known
      end
    elseif isnothing(distinctpair)
      println(equalpair)
      readline()
      println(equalpair) # keep querycount even
      newbit = parse(Int, readline())
      if newbit != known[equalpair]
        known = .!known
      end
    else
      println(equalpair)
      newequalbit = parse(Int, readline())
      println(distinctpair)
      newdistinctbit = parse(Int, readline())
      # println(stderr, "Queried $equalpair and $distinctpair and received $newequalbit and $newdistinctbit")
      if newequalbit == known[equalpair] && newdistinctbit != known[distinctpair]
        reverse!(known)
        # println(stderr, "Detected reverse on query $querycount")
      elseif newequalbit != known[equalpair] && newdistinctbit == known[distinctpair]
        reverse!(known)
        known = .!known
        # println(stderr, "Detected flip and reverse on query $querycount")
      elseif newequalbit != known[equalpair] && newdistinctbit != known[distinctpair]
        known = .!known
        # println(stderr, "Detected flip on query $querycount")
      end
    end

    querycount += 2
  end
end

function getnextbit(bit, b)
  if bit == ceil(Int, (b+1)/2)
    return nothing
  elseif bit <= b ÷ 2
    return b + 1 - bit
  elseif bit > b ÷ 2
    return b + 1 - bit + 1
  end
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
