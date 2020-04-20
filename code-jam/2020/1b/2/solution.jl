import Base.length

mutable struct Interval
  in::Int
  out::Int
end

length(interval::Interval) = abs(interval.in - interval.out)
middle(interval::Interval) = (interval.in + interval.out) ÷ 2

function solve()
  t,a,b = tointarray(readline())

  for x in 1:t
    solve_case(a,b)
  end
end

function solve_case(a,b)
  x_hit, y_hit = 0, 0
  for x in -10^9:a:10^9, y in -10^9:a:10^9
    println("$x $y")
    answer = readline()
    if answer == "CENTER"
      return
    elseif answer == "HIT"
      x_hit, y_hit = x, y
      break
    end
  end

  interval_left = Interval(x_hit, max(x_hit - 2*b - 1, -10^9 - 1))
  if search(interval_left, y_hit, true) return end
  left = interval_left.in

  interval_right = Interval(x_hit, min(x_hit + 2*b + 1, 10^9 + 1))
  if search(interval_right, y_hit, true) return end
  right = interval_right.in

  interval_top = Interval(y_hit, min(y_hit + 2*b + 1, 10^9 + 1))
  if search(interval_top, x_hit, false) return end
  top = interval_top.in

  interval_bottom = Interval(y_hit, max(y_hit - 2*b - 1, -10^9 - 1))
  if search(interval_bottom, x_hit, false) return end
  bottom = interval_bottom.in

  x = (left + right) ÷ 2
  y = (top + bottom) ÷ 2

  println("$x $y")
  readline()
end

function search(interval::Interval, other, isxinterval)
  while length(interval) > 1
    center = middle(interval)
    if isxinterval
      println("$center $other")
    else
      println("$other $center")
    end
    answer = readline()
    if answer == "CENTER"
      return true
    elseif answer == "HIT"
      interval.in = center
    elseif answer == "MISS"
      interval.out = center
    else
      throw("Wrong input")
    end
  end
  return false
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
