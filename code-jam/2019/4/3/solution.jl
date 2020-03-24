function solve()
  t = parse(Int, readline())

  for x in 1:t
    s = parse(Int, readline())
    ys = solve_case(s)
    println("Case #$x: $(join(ys, ' '))")
  end
end

function solve_case(s)
  if ispalindrome(s) 
    return [s]
  end
  ys = twoterms(s)

  return ys
end

# IMPROVE HERE: Go through all possible palindrome lenghts
# Watch out for the carry!
# For three palindromes: Pick the first randomly (since there are enough)
function twoterms(s)
  digits1 = digits(s)
  digits2 = []
  for i in 1:length(ceil(Int, digits/2))
    for digit2 in 1:9

    end
  end
end

function ispalindrome(number)
  str = string(number)
  return str == reverse(str)
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
