import Base.split

mutable struct Segment
  first_input::Int
  last_input::Int
  first_output::Int
  last_output::Int
end

function inputlength(segment::Segment)::Int
  return segment.last_input - segment.first_input + 1
end

function outputlength(segment::Segment)::Int
  return segment.last_output - segment.first_output + 1
end

function countbroken(segment::Segment)::Int
  return inputlength(segment) - outputlength(segment)
end

function alternate(segments::Array{Segment})
  str = ""
  bit = "0"
  for seg in segments
      str *= repeat(bit, inputlength(seg))
      bit = bit == "0" ? "1" : "0"
  end
  return str
end

function solve()
  t = parse(Int, readline())

  for case_index in 1:t
    n, b, f = map(i -> parse(Int, i), split(readline()))
    
    brokenworkers = solve_case(n, b, f)
    brokenworkers = map(i -> i-1, brokenworkers)
    println(join(brokenworkers, ' '))
    iscorrect = parse(Int, readline()) == 1
    if !iscorrect return end
  end
end

# returns the ids of the broken workers in sorted order
function solve_case(n, b, f)::Array{Int}
  segment_length_init = b+1
  segments = Array{Segment,1}()
  for first_index in 1:segment_length_init:n
    last_index = min(first_index + segment_length_init - 1, n)
    push!(segments, Segment(first_index, last_index, -1, -1))
  end
  
  println(alternate(segments))
  answer = readline()
  segment_lengths = get_segment_lengths(answer)
  # the last segment could be cut off completely
  if length(segment_lengths) < length(segments) 
    push!(segment_lengths, 0)
  end

  # Map the segments to their output intervals
  first_output = 1
  for i in 1:length(segments)
    last_output = first_output + segment_lengths[i] - 1
    segments[i].first_output = first_output
    segments[i].last_output = last_output
    first_output = last_output + 1
  end

  for i in 2:f
    @debug "segements" segments
    segments = split_segments(segments)
    println(alternate(segments))
    answer = readline()
    for i in 1:length(segments)
      seg = segments[i]
      bit = isodd(i) ? '0' : '1'
      output_indices = findall(c -> c==bit, answer[seg.first_output:seg.last_output])
      @debug "output_indices" output_indices
      if length(output_indices) > 0
        seg.last_output = maximum(output_indices) + seg.first_output - 1
        seg.first_output = minimum(output_indices) + seg.first_output - 1
      else
        seg.first_output, seg.last_output = 0, -1
      end
    end
  end

  @debug "segements" segments
  @assert all(s -> s.first_input == s.last_input, segments)

  brokenworkers = []
  for seg in segments
    if seg.last_output < seg.first_output
      push!(brokenworkers, seg.first_input)
    end
  end
  return brokenworkers
end

function split_segments(segments::Array{Segment,1})
  segments = map(split, segments)
  return reduce(vcat, segments)
end

function split(s::Segment) 
  if s.last_input == s.first_input
    return [s]
  end

  middle = (s.last_input + s.first_input) ÷ 2
  return [
    Segment(s.first_input, middle      , s.first_output, s.last_output),
    Segment(middle + 1   , s.last_input, s.first_output, s.last_output),
  ] 
end

function get_segment_lengths(bits) 
  bits_array = map(x->parse(Int,x), split(bits, ""))
  Segment_ends = findall(diff(bits_array) .!= 0)
  push!(Segment_ends, length(bits))
  segment_lengths = diff(pushfirst!(Segment_ends, 0))
  return segment_lengths
end

solve()