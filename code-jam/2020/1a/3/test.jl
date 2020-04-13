using Test

include("./solution.jl")

@test solve_case(3, 3, [1 1 1; 1 2 1; 1 1 1]) == 16

r, c = 100, 1000
ss = Array{Int,2}(undef,r,c)
ss = map(x -> rand(1:10^4), ss)

@timev solve_case(r,c,ss)
