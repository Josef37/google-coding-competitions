using Printf

function solve() 
  t = parse(Int, readline())

  for x in 1:t
    n, k = to_int_array(readline())
    heights = to_int_array(readline())
    @assert (length(heights) == n) "Number of heights doesn't match"

    y = solve_case(n, k, heights)

    @printf("Case #%d: %d\n", x, y)
  end
end

function solve_case(n, k, heights)
  #= 
    1. Count all changes in height 
    2. How many changes too much?
    3. Changing a height (rebuilding) can at most reduce changes by 2
        (when left and right are the same height, but current isn't)
    4. A naive approach would just make one improvement each rebuild
        WRONG: Consider k=0, heights=[1,1,2,2]
    5. When there are k changes, there are at most k+1 heights
  =#
end

function to_int_array(string) 
  return map(n -> parse(Int, n), split(string))
end

solve()