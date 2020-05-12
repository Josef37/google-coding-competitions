using Test

include("./solution.jl")

@test getvector(SimpleInstruction('E')) == [1,0]
@test getvector(SpecialInstruction(2, [SimpleInstruction('E')])) == [2,0]
@test getsubprogs("NSW2(EE)W") == ["N","S","W","2(EE)","W"]
