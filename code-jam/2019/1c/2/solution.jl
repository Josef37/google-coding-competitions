function solve()
  t, f = tointarray(readline())

  for x in 1:t
    y = solve_case(f)
    println(y)
    if readline() == "N"
      exit(1)
    end
  end
end

function solve_case(f)
  missingset = ""
  setstocheck = collect(0:118)
  for i in 1:5
    answers = Dict()
    for set in setstocheck
      println(5*set + i)
      answers[set] = readline()[1]
    end
    counts = Dict()
    for char in "ABCDE"
      counts[char] = count(c -> c == char, values(answers))
    end
    missingchar = filter(char -> counts[char] < factorial(5-i), setdiff("ABCDE", missingset))[1]
    missingset *= missingchar
    filter!(set -> answers[set] == missingchar, setstocheck)
  end

  return missingset
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
