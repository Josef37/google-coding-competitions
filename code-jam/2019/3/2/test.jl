using Test

include("./solution.jl")

@test getcost([1,6,2,5,7]) == 5
