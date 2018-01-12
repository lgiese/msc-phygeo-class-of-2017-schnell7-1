def fak(x):
    if x > 1:
        return(x * fak(x-1))
    else:
        return(x)
n = 5
for i in range(1,n):
    n = n*(n-i)

print(n)

