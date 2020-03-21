using Printf

t = parse(Int, readline())

for (i, n) in enumerate(readlines())
    a = ""
    b = ""
    for digit in n
        if digit == '4'
            a *= '2'
            b *= '2'
        else
            a *= digit
            b = b == "" ? "" : b * '0'
        end
    end
    b = b == "" ? "0" : b
    @printf("Case #%s: %s %s\n", i, a, b)
end
