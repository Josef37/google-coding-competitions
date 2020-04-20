function solve()
  t = parse(Int, readline())

  for x in 1:t
    r,s = tointarray(readline())
    ys = solve_case(r,s)
    println("Case #$x: $(size(ys, 1))")
    for (a,b) in eachrow(ys)
      println("$a $b")
    end
  end
end

function solve_case(r,s)
  # Ignore the suite
  stack = repeat(collect(1:r), s)

  # Operations
  ys = reshape([], 0, 2)

  while true
    a = 0
    b = 0

    # Pick up all matching first rank
    while a+1 <= length(stack) && stack[a+1] == stack[1]
      a += 1
    end
    # Pick up all of next rank
    while a+1 <= length(stack) && stack[a+1] == stack[1] % r + 1
      a += 1
    end

    # Pick up until first rank shows up
    while a+b+1 <= length(stack) && stack[a+b+1] != stack[1]
      b += 1
    end
    # Pick up all of first rank
    while a+b+1 <= length(stack) && stack[a+b+1] == stack[1]
      b += 1
    end

    # Last card got picked up?
    if length(stack) == a+b
      a = 0

      # Pick up all of the last rank
      while a+1 <= length(stack) && stack[a+1] == stack[end]
        a += 1
      end

      # No card picked up? It is already sorted!
      if 0 == a
        break
      end
      
      # Pick up the rest into b
      b = length(stack) - a
    end

    # Store the operation
    ys = vcat(ys, [a b])

    # Perform the operation
    swap!(stack, a, b)
  end

  return ys
end

function swap!(stack, a, b)
  stack[1:b], stack[b+1:a+b] = stack[a+1:a+b], stack[1:a]
  return stack
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
