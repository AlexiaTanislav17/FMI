def orientare(p, q, r):
    det = (q[0] - p[0]) * (r[1] - q[1]) - (q[1] - p[1]) * (r[0] - q[0])
    
    if det < 0:
        return -1  # dr
    elif det > 0:
        return 1  # stg
    else:  # val == 0
        return 0  # coliniar

def convex_hull(points):
    n = len(points)
    if n <= 3:
        return points
    

    extended_points = points + [points[0]]
    hull = [points[0]]
    
    for i in range(1, n + 1):
        while len(hull) >= 2 and orientare(hull[-2], hull[-1], extended_points[i]) != 1:
            hull.pop()
        
        if i < n:
            hull.append(extended_points[i])
    
    return hull


n = int(input())
points = []
for i in range(n):
    x, y = map(int, input().split())
    points.append((x, y))


hull = convex_hull(points)
print(len(hull))
for point in hull:
    print(point[0], point[1])












