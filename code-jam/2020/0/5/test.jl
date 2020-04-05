using Test

include("./solution-jump.jl")

function test(max_n=5)
  for n in 1:max_n
    for k in n:n*n
      solution = solve_case(n, k)
      if isempty(solution)
        println("$n $k IMPOSSIBLE")
      else
        trace = [solution[i,i] for i in 1:n]
        println("$n $k trace $trace")
      end
    end
    println()
  end
end

test(6)

#=

1 1 trace [1]

2 2 trace [1, 1]
2 3 IMPOSSIBLE
2 4 trace [2, 2]

3 3 trace [1, 1, 1]
3 4 IMPOSSIBLE
3 5 IMPOSSIBLE
3 6 trace [3, 2, 1]
3 7 IMPOSSIBLE
3 8 IMPOSSIBLE
3 9 trace [3, 3, 3]

4 4 trace [1, 1, 1, 1]
4 5 IMPOSSIBLE
4 6 trace [1, 2, 1, 2]
4 7 trace [1, 1, 3, 2]
4 8 trace [3, 2, 2, 1]
4 9 trace [1, 1, 3, 4]
4 10 trace [4, 4, 1, 1]
4 11 trace [4, 4, 1, 2]
4 12 trace [4, 3, 1, 4]
4 13 trace [2, 4, 4, 3]
4 14 trace [3, 4, 4, 3]
4 15 IMPOSSIBLE
4 16 trace [4, 4, 4, 4]

5 5 trace [1, 1, 1, 1, 1]
5 6 IMPOSSIBLE
5 7 trace [1, 2, 1, 2, 1]
5 8 trace [1, 1, 2, 3, 1]
5 9 trace [2, 3, 1, 1, 2]
5 10 trace [1, 1, 1, 4, 3]
5 11 trace [1, 4, 1, 4, 1]
5 12 trace [1, 3, 3, 3, 2]
5 13 trace [1, 1, 3, 5, 3]
5 14 trace [4, 2, 2, 5, 1]
5 15 trace [5, 2, 4, 2, 2]
5 16 trace [1, 5, 3, 4, 3]
5 17 trace [5, 4, 4, 2, 2]
5 18 trace [5, 2, 5, 1, 5]
5 19 trace [5, 3, 5, 5, 1]
5 20 trace [3, 5, 4, 5, 3]
5 21 trace [4, 5, 5, 5, 2]
5 22 trace [5, 5, 3, 4, 5]
5 23 trace [4, 5, 5, 5, 4]
5 24 IMPOSSIBLE

=#