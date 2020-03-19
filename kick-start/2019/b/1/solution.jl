using Printf
import Base.-

function solve() 
  t = parse(Int, readline())

  for x in 1:t
    n, q = to_int_array(readline())
    chars = readline()
    bounds = [to_int_array(readline()) for i in 1:q]

    y = count_palindromes2(chars, bounds)
    @printf("Case #%d: %d\n", x, y)
  end
end

function to_int_array(string) 
  return map(n -> parse(Int, n), split(string))
end

function -(d1::Dict{Char,Int}, d2::Dict{Char,Int}) 
  d = Dict{Char,Int}()
  for k in union(keys(d1), keys(d2))
    d[k] = get(d1, k, 0) - get(d2, k, 0)
  end
  return d
end

function count_palindromes(chars, bounds) 
  possible_palindromes = 0
  for (l, r) in bounds
    possible_palindromes += can_be_palindrome(count_chars(chars[l:r]))
  end
  return possible_palindromes
end

function count_palindromes2(chars, bounds)
  alphabet_length = Int('Z') - Int('A') + 1
  charcode_delta = Int('A') - 1
  char_counts = fill(0, alphabet_length)
  prefix_counts = [copy(char_counts)]
  for char in chars
    char_counts[Int(char) - charcode_delta] += 1
    push!(prefix_counts, copy(char_counts))
  end

  possible_palindromes = 0
  for (l, r) in bounds
    possible_palindromes += can_be_palindrome(prefix_counts[r+1] - prefix_counts[l])
  end
  return possible_palindromes
end

function count_chars(string) 
  char_counts = Dict{Char, Int}();
  for char in string
    char_counts[char] = get(char_counts, char, 0) + 1
  end
  return char_counts
end

function can_be_palindrome(char_counts) 
  return count(isodd, values(char_counts)) <= 1
end

solve()
