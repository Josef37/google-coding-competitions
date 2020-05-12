struct SimpleInstruction
  direction::Char
end

struct SpecialInstruction
  repeat::Int
  subinstructions::Array{Union{SimpleInstruction,SpecialInstruction}}
end

function getvector(instruction::SpecialInstruction, modulo = 10^9)
  return mod.(instruction.repeat * sum(getvector, instruction.subinstructions), modulo)
end

function getvector(instruction::SimpleInstruction)
  if 'N' == instruction.direction
    return [ 0,-1]
  elseif 'E' == instruction.direction
    return [ 1, 0]
  elseif 'S' == instruction.direction
    return [ 0, 1]
  elseif 'W' == instruction.direction
    return [-1, 0]
  else
    throw("Invalid direction")
  end
end

function solve()
  t = parse(Int, readline())

  for x in 1:t
    prog = readline()
    w,h = solve_case(prog)
    println("Case #$x: $w $h")
  end
end

function getsubprogs(prog)
  parencount = 0
  subprogs = []
  for char in prog
    if char == '('
      parencount += 1
    elseif char == ')'
      parencount -= 1
    end
    
    if parencount > 0 || char == ')'
      subprogs[end] *= char
    else
      push!(subprogs, string(char))
    end
  end

  return subprogs
end

function parseprog(prog)
  if length(prog) == 1
    return SimpleInstruction(first(prog))
  end

  return SpecialInstruction(
    parse(Int, prog[1]), 
    [parseprog(subprog) for subprog in getsubprogs(prog[3:end-1])]
  )
end

function solve_case(prog)
  root = SpecialInstruction(1, [parseprog(subprog) for subprog in getsubprogs(prog)])
  return [1,1] + getvector(root)
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
