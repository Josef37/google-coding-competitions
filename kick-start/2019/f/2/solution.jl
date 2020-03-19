using Printf

function solve() 
  t = parse(Int, readline())

  for x in 1:t
    n, s = to_int_array(readline())
    skills = []
    for i in 1:n
      push!(skills, Set(to_int_array(readline())[2:end]))
    end

    y = solve_case(n, s, skills)

    @printf("Case #%d: %d\n", x, y)
  end
end

function solve_case(n, s, skills)
  pairs = 0
  for i in 1:length(skills)
    for j in 1:length(skills)
      pairs += length(setdiff(skills[i], skills[j])) > 0
    end
  end
  return pairs
end

function to_int_array(string) 
  return map(n -> parse(Int, n), split(string))
end

solve()