using Printf

function solve() 
  t = parse(Int, readline())

  for x in 1:t
    n, s = to_int_array(readline())
    trinkets = to_int_array(readline())

    @assert (length(trinkets) == n) "Number of trinkets doesn't match"

    y = solve_case(n, s, trinkets)
    @printf("Case #%d: %d\n", x, y)
  end
end

function solve_case(n, s, trinkets)
    max_l, max_r, max_y = 0, 0, 0
    counts = Dict{Int, Int}()
    foreach(t -> counts[t] = 0, trinkets)

    l, r, y = 1, 0, 0

    while r < length(trinkets) 
      # take new trinkets as long as possible (and one more)
      while true
        y += 1
        r += 1
        new_type = trinkets[r]
        counts[new_type] += 1

        @debug (@sprintf("Taking trinket %d", r))

        # took the violation trinket
        if counts[new_type] > s
          @debug "Violation found!"

          if y-1 > max_y
            max_l, max_r, max_y = l, r-1, y-1
          end

          break
        end

        if r == length(trinkets)
          @debug "Took last trinket without violation"

          if y > max_y
            max_l, max_r, max_y = l, r, y
          end

          return max_y
        end
      end      
      
      # drop old trinkets until valid again
      while l <= r
        old_type = trinkets[l]
        y -= 1
        l += 1
        counts[old_type] -= 1

        @debug (@sprintf("Dropping trinket %d", l-1))

        # dropped the violating trinket
        if counts[old_type] == s
          @debug "Violation resolved!"
          break
        end
      end
    end
    return max_y
end

function to_int_array(string) 
  return map(n -> parse(Int, n), split(string))
end

solve()