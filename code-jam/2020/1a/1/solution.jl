function solve()
  t = parse(Int, readline())

  for x in 1:t
    n = parse(Int, readline())
    ps = [readline() for _ in 1:n]
    y = solve_case(n, ps)
    println("Case #$x: $y")
  end
end

function solve_case(n, ps)
  #=
    suffixes and prefixes have to be equal -> reduce problem

    since there are at most 50 patterns with a length of at most 100 characters
    the shortest possible solution is at most 5000 characters long 
    (every character fulfills at least one pattern character)
  =#

  sections = map(p -> split(p, "*"), ps)
  prefixes = map(first, sections)
  suffixes = map(last, sections)
  longestprefix = prefixes[argmax(map(length, prefixes))]
  longestsuffix = suffixes[argmax(map(length, suffixes))]

  hassameprefix = all(prefix -> startswith(longestprefix, prefix), prefixes)
  hassamesuffix = all(suffix -> endswith(longestsuffix, suffix), suffixes)

  if hassameprefix && hassamesuffix
    middle = join(map(section -> join(section[2:end-1]), sections))
    return longestprefix * middle * longestsuffix
  else
    return "*"
  end
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
