using Test
include("./solution.jl")

@test getmovebounds(10^10) == (1,1)
@test getmovebounds(2 * 10^10) == (1,2)
@test getmovebounds(3 * 10^10 - 2) == (1,2)
@test getmovebounds(10^12) == (50,100)