struct Node
  children::Dict{Char,Node}
end

winningmovedict = Dict(
  'R' => 'P',
  'P' => 'S',
  'S' => 'R'
)

function solve()
  t = parse(Int, readline())

  for x in 1:t
    a = parse(Int, readline())
    cs = [readline() for _ in 1:a]

    y = solve_case(a, cs)

    println("Case #$x: $y")
  end
end

function solve_case(a, cs)
  @assert length(cs) == a

  # every move you eliminate at least one opponent, so the tree depth is a
  root = buildtree(a, cs)

  # traverse tree from root
  # when there are three children, you won't win
  # two children: pick the winning one and follow this path
  # one child: beat it (tying is just a waste of time)
  # zero children: nothing to do
  node = root
  program = ""
  while true
    if length(node.children) == 0
      break
    elseif length(node.children) == 1
      program *= winningmovedict[first(keys(node.children))]
      break
    elseif length(node.children) == 2
      moves = collect(keys(node.children))
      winningmove = getwinningmove(moves[1], moves[2])
      program *= winningmove
      node = node.children[winningmove]
    elseif length(node.children) == 3
      return "IMPOSSIBLE"
    end
  end

  return program
end

function buildtree(depth, programs)
  root = Node(Dict())
  for program in programs
    node = root
    for move in repeat(program, ceil(Int, depth / length(program)))[1:depth]
      if haskey(node.children, move)
        node = node.children[move]
      else 
        newnode = Node(Dict())
        node.children[move] = newnode
        node = newnode
      end
    end
  end

  return root
end

function getwinningmove(m1, m2)
  @assert m1 != m2
  return winningmovedict[m1] == m2 ? m2 : m1
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
