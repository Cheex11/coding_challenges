def fib_nth(n)
  n1, n2 = 0, 1
  n3 = n1 + n2
  i = 0
  until n1 > n
    puts n1
    i += 1
    n1 = n2
    n2 = n3
    n3 = n1 + n2
  end
end

print "What number do you want to Fibonacci to?"
n = gets.strip.to_i
fib_nth(n)
