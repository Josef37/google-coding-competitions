import Base.angle

# a * x <= b
struct Line
  a::Array{Int,1}
  b::Int
end

in(line::Line, x::Array{Int,1}) = line.a' * x <= line.b

function solve()
  t = parse(Int, readline())

  for x in 1:t
    n = parse(Int, readline())
    ps = [tointarray(readline()) for _ in 1:2*n]
    ys = solve_case(n, ps)
    println("Case #$x: $(join(ys, ' '))")
  end
end

function solve_case(n, ps)
  # each pair should cross each other
  # so a pair has to divide the jugglers

  # IMPROVE HERE: Rotate around an outermost point
  # Divide and conquer: There is only on possible pairing
  center = sum(ps) / length(ps)
  ps = sort!(collect(enumerate(ps)), by = ((i, p),) -> angle(p - center))
  ys = Array{Int,1}(undef, 2*n)
  for i in 1:n
    p1 = ps[i][1]
    p2 = ps[i+n][1]
    ys[p1] = p2
    ys[p2] = p1
  end

  return ys
end

angle(vector::Array) = atan(vector[2], vector[1])

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
