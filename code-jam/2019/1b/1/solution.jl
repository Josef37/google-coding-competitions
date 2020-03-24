struct Person
  pos::Array{Int,1}
  dir::Char
end

directions = Dict(
  'N' => [0,1],
  'E' => [1,0],
  'S' => [0,-1],
  'W' => [-1,0]
)

function solve()
  t = parse(Int, readline())

  for x in 1:t
    p,q = tointarray(readline())
    ps = map(_ -> begin 
        x_,y_,d = split(readline())
        Person([parse(Int,x_), parse(Int,y_)], d[1])
      end , 1:p)
    y = solve_case(q, ps)
    println("Case #$x: $(join(y, ' '))")
  end
end

function solve_case(q, ps)
  xcount = fill(0, q+1)
  ycount = fill(0, q+1)
  for person in ps
    x, y = person.pos + [1,1]
    dir = person.dir
    if dir == 'N'
      ycount[y+1:end] .+= 1
    elseif dir == 'E'
      xcount[x+1:end] .+= 1
    elseif dir == 'S'
      ycount[1:y-1] .+= 1
    elseif dir == 'W'
      xcount[1:x-1] .+= 1
    end
  end
  return [argmax(xcount)-1, argmax(ycount)-1]
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
