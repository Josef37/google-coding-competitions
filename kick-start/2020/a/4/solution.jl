function solve()
  t = parse(Int, readline())

  for x in 1:t
    n, k = tointarray(readline())
    words = [readline() for _ in 1:n]
    y = solve_case3(n, k, words)
    println("Case #$x: $y")
  end
end

mutable struct Node
  char::Union{Char,Nothing}
  children::Array{Node,1}
  count::Int
end

count(node::Node, k::Int) = cap(node.count, k) + (isempty(node.children) ? 0 : sum(n -> count(n, k), node.children))
cap(count::Int, k::Int) = floor(Int, count / k)

function solve_case3(n, k, words) 
  @assert n == length(words)
  @assert n % k == 0

  root = buildtrie(words)
  @debug "trie" root
  return count(root, k)
end


function buildtrie(words)
  root = Node(nothing, [], 0)
  for word in words
    insert!(root, word)
  end
  return root
end

function insert!(node::Node, word::String)
  for char in word
    if char in map(n -> n.char, node.children)
      index = findfirst(n -> char == n.char, node.children)
      node = node.children[index]
    else
      newnode = Node(char, [], 0)
      push!(node.children, newnode)
      node = newnode
    end
    node.count += 1
  end
end

function solve_case2(n, k, words) 
  @assert n == length(words)
  @assert n % k == 0

  prefixmap = generateprefixmap(words)
  score = 0
  for prefix in keys(prefixmap)
    words = prefixmap[prefix]
    score += floor(Int, length(words) / k)
  end
  return score
end

function solve_case(n, k, words)
  @assert n == length(words)
  @assert n % k == 0

  prefixmap = generateprefixmap(words)
  @debug "prefixmap before filter" prefixmap
  # delete prefixes with less than k words
  filter!(((prefix,words),) -> length(words) >= k, prefixmap)
  @debug "prefixmap after filter" prefixmap
  prefixesbylength = sort!(collect(keys(prefixmap)); rev=true)
  score = 0
  for prefix in prefixesbylength
    # when you take the longest prefixes, it doesn't matter which ones you pick
    # because the words are equal, from the prefix perspective of other words
    wordindices = prefixmap[prefix]
    if length(wordindices) < k
      continue
    end
    for i in 1:k:(length(wordindices)-k+1)
      println("$i, $k, $wordindices")
      score += length(prefix)
      group = wordindices[i:i+k-1]
      @debug map(w -> words[w], group) 
      for wordindex in group
        deleteword!(prefixmap, wordindex, words[wordindex])
      end
    end

    @debug "prefixmap after grouping" prefixmap
  end

  return score
end

function deleteword!(prefixmap, wordindex, word) 
  for j in eachindex(word)
    prefix = word[1:j]
    if haskey(prefixmap, prefix)
      filter!(index -> index != wordindex, prefixmap[prefix])
    end
  end
end

function generateprefixmap(words)
  map = Dict{String,Array{Int,1}}()
  for (wordindex, word) in enumerate(words)
    for j in eachindex(word)
      prefix = word[1:j]
      map[prefix] = push!(get(map, prefix, []), wordindex)
    end
  end
  return map
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

function generate(t, max_l, max_n = 10^2, chars=collect('A':'Z'))
  str = "$t\n"
  for _ in 1:t
    n = rand(2:max_n)
    k = rand(filter(x -> n % x == 0, 2:n))
    str *= "$n $k\n"
    for _ in 1:n
      l = rand(1:max_l)
      str *= join([rand(chars) for _ in 1:l]) * "\n"
    end
  end
  write("testgen.in", str)
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end
