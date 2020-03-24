function solve()
  t = parse(Int, readline())

  for x in 1:t
    p, s, k, n = tointarray(readline())
    as = Array{Int,2}(undef, k, n)
    for i in 1:k
      as[i, :]= tointarray(readline())
    end
    ps, ss = solve_case(p, s, k, n, as)
    println("Case #$x:")
    println(length(ps))
    for p in ps 
      println(join(p, '')) 
    end
    for s in ss 
      println("$(length(s)) $(join(s, ''))") 
    end
  end
end

# IMPROVE HERE: Hash sort was not a bad idea...
# But you don't have to compare, you just have to sort!
# Leave the last as a buffer and change it with the second-to-last
# The other permutations are for rotating (1 .. n-1)
function solve_case(p, s, k, n, as)
  return 0
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
