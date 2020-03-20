function solve()
  t = parse(Int, readline())

  for x in 1:t
    n = parse(Int, readline())
    ws = [readline() for _ in 1:n]
    y = solve_case(n, ws)
    println("Case #$x: $y")
  end
end

function makemap(ws) 
  suffix_to_indices = Dict{String, Array{Int, 1}}()
  for (i, w) in enumerate(ws)
    for s in 1:length(w)
      suffix = w[s:end]
      if haskey(suffix_to_indices, suffix)
        push!(suffix_to_indices[suffix], i)
      else
        suffix_to_indices[suffix] = [i]
      end
    end
  end
  return suffix_to_indices
end

function rhyme(w1, w2, suffix, ws, rhymed, suffix_to_indices, suffixes_to_check) 
  @debug "rhyming $(ws[w1]) and $(ws[w2]) at $suffix"
  push!(rhymed, w1, w2)
  delete!(suffix_to_indices, suffix)
  for w in [w1, w2]
    word = ws[w]
    for s in 1:length(word)
      suffix = word[s:end]
      if haskey(suffix_to_indices, suffix)
        filter!(i -> i != w, suffix_to_indices[suffix])
        push!(suffixes_to_check, suffix)
      end
    end
  end
end

function solve_case(n, ws)
  # map suffix to word index
  suffix_to_indices = makemap(ws)
  rhymed = Set()
  suffixes_to_check = Set(keys(suffix_to_indices))
  while true
    while !isempty(suffixes_to_check)
      suffix = pop!(suffixes_to_check)
      words = suffix_to_indices[suffix]
      # ignore suffixes with less than two words
      if length(words) < 2
        delete!(suffix_to_indices, suffix)
      # rhyme exactly two equal suffixes, delete them from dictionary
      elseif length(words) == 2
        rhyme(words..., suffix, ws, rhymed, suffix_to_indices, suffixes_to_check)
      end
    end

    if isempty(suffix_to_indices) break end

    # then rhyme the longest remaining suffixes
    longest_suffix = first(sort(collect(keys(suffix_to_indices)); by=length, rev=true))
    words = suffix_to_indices[longest_suffix][1:2]
    rhyme(words..., longest_suffix, ws, rhymed, suffix_to_indices, suffixes_to_check)
  end

  return length(rhymed)
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

if abspath(PROGRAM_FILE) == @__FILE__
  solve()
end