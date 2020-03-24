function solve()
  t = parse(Int, readline())

  for x in 1:t
    n, k = tointarray(readline())
    cs = tointarray(readline())
    ds = tointarray(readline())
    y = solve_case(n,k,cs,ds)
    println("Case #$x: $y")
  end
end

function solve_case(n,k,cs,ds)
  count = fill(0, n)
  for i in reverse(1:n)
    if i < n && cs[i] <= cs[i+1] && ds[i] <= ds[i+1]
      count[i] = count[i+1] + (k >= abs(cs[i] - ds[i]))
      continue
    end
    max_c, max_d = 0, 0
    for j in i:n
      max_c = max(max_c, cs[j])
      max_d = max(max_d, ds[j])
      count[i] += k >= abs(max_c - max_d)
    end
  end
  return sum(count)
end

getnextmaxs(arr) = [findnext(x -> x >= arr[i], arr, i+1) for i in eachindex(arr)]
getsegmentlengths(arr) = diff(findall(diff(pad!(arr, true)) .!= 0))[1:2:end]
pad!(arr, e) = pushfirst!(push!(arr, e), e)

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

function generate(t=100, max_n=10^5, max_k=10^5, max_val=10^5)
  str = "$t\n"
  for _ in 1:t
    n = rand(1:max_n)
    k = rand(1:max_k)
    str *= "$n $k\n"
    for _ in ['c','d']
      str *= join([rand(1:max_val) for _ in 1:n], ' ') * "\n"
    end
  end
  write("testgen.in", str)
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
