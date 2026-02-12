from functools import reduce

print("This is a print statement")  # noqa: T201
assert reduce(lambda x, y: x + y, range(1,100)) == 100

d = dict(a=1, b=2) # noqa: C408
