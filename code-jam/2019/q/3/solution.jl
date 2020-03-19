using Printf

function solve() 
  t = parse(Int, readline())

  for x in 1:t
    n, l = map(x -> parse(BigInt, x), split(readline()))
    ciphertext = map(x -> parse(BigInt, x), split(readline()))

    y = solvecase(n, l, ciphertext)
    @printf("Case #%d: %s\n", x, y)
  end
end

function solvecase(n, l, ciphertext)
  ciphers = fill(BigInt(0), l+1)
  b = findbreakingpoint(l, ciphertext)
  @debug "Breaking point" b
  ciphers[b] = gcd(ciphertext[b-1], ciphertext[b])
  @debug "cipher at b" ciphers[b]
  for i in b:l
    ciphers[i+1] = div(ciphertext[i], ciphers[i])
  end
  for i in b-1:-1:1
    ciphers[i] = div(ciphertext[i], ciphers[i+1])
    @debug "computing previous cipher" ciphers[i]
  end

  table = makedeciphertable(ciphers)
  text = map(p -> table[p], ciphers)
  return join(text)
end

function findbreakingpoint(l, ciphertext) 
  for b in 2:l
    if ciphertext[b-1] != ciphertext[b]
      return b
    end
  end
end

function makedeciphertable(ciphers)
  primes = sort!(unique(ciphers))
  table = Dict(map(makepair, enumerate(primes)))
  return table
end

function makepair(tuple)
  index, prime = tuple
  return (prime, getchar(index))
end

function getchar(index) 
  return index - 1 + 'A'
end

function tointarray(string) 
  return map(n -> parse(Int, n), split(string))
end

solve()