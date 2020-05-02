function solve()
  t = parse(Int, readline())
  
  for x in 1:t
    u = parse(Int, readline())
    input = Array{String,2}(undef,10^4,2)
    for i in 1:10^4
      input[i,:] = split(readline())
    end
    y = solve_case(u,input)
    println("Case #$x: $y")
  end
end

function solve_case(u,input)
  d = Array{Union{Nothing,Char}}(nothing,9)

  digitcounts = Dict{Char,Int}()
  for (q,r) in eachrow(input)
    char = r[1]
    digitcounts[char] = 1 + get(digitcounts, char, 0)
  end

  d = map(first, sort(collect(digitcounts); by=x->x[2], rev=true))

  # find 0
  for (q,r) in eachrow(input) 
    index = findfirst(digit -> !(digit in d), r)
    if !isnothing(index)
      pushfirst!(d, r[index])
      break
    end
  end

  return join(d,"")
end

function generate(u = 16, d = "ABCDEFGHIJ")
  str = "1\n$u\n"
  for i in 1:10^4
    m = rand(1:10^u - 1)
    n = rand(1:m)
    r = join(map(digit -> d[digit+1], reverse(digits(n))), "")
    str *= "$m $r\n"
  end
  write("testgen.in", str);
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
