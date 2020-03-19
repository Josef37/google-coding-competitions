using Printf

function solve() 
  t = parse(Int, readline())

  for x in 1:t
    n = parse(Int, readline())
    path = readline()

    y = solve_case(n, path)
    @printf("Case #%d: %s\n", x, y)
  end
end

function solve_case(n, path)
  # Just invert the instructions
  # If her position is (x,y), yours is (y,x). 
  # So you only meet, when x=y, but you took a different path.
  return map(d -> d == 'E' ? 'S' : 'E', path)
end


function to_int_array(string) 
  return map(n -> parse(Int, n), split(string))
end

solve()