using Test

include("./solution.jl")

@test getgroupmembers(1,1,3,3,[0 0 0; 1 1 0; 0 1 0]) == [[1,1],[1,2],[1,3],[2,3],[3,3]]
