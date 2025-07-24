def orientare(p, q, r):
    val = (q[0] - p[0]) * (r[1] - p[1]) - (q[1] - p[1]) * (r[0] - p[0])
    
    if val < 0:
        return "RIGHT"
    elif val > 0:
        return "LEFT"
    else:
        return "TOUCH"


def pe_segment(p, q, r):
    return (r[0] <= max(p[0], q[0]) and r[0] >= min(p[0], q[0]) and
            r[1] <= max(p[1], q[1]) and r[1] >= min(p[1], q[1]) and
            orientare(p, q, r) == "TOUCH")


def margine(polygon, point):
    n = len(polygon)
    for i in range(n):
        if pe_segment(polygon[i], polygon[(i + 1) % n], point):
            return True
    return False


def cautare_binara(polygon, point):
    n = len(polygon)
    if margine(polygon, point):
        return "BOUNDARY"
    
    p0 = polygon[0]
    left, right = 1, n - 1
    while left < right:
        mid = (left + right) // 2
        if orientare(p0, polygon[mid], point) == "LEFT":
            left = mid + 1
        else:
            right = mid
    
    if orientare(p0, polygon[left], point) == "LEFT" and \
       orientare(polygon[left], polygon[(left + 1) % n], point) == "LEFT" and \
       orientare(polygon[(left + 1) % n], p0, point) == "LEFT":
        return "INSIDE"
    return "OUTSIDE"



n = int(input())
polygon = []
for i in range(n):
    x, y = map(int, input().split())
    polygon.append((x, y))

m = int(input())
for i in range(m):
    x, y = map(int, input().split())
    point = (x, y)
    print(cautare_binara(polygon, point))