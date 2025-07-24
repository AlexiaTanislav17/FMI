n = int(input())
points = []

for i in range(n):
    data = input().split()
    x = int(data[0])
    y = int(data[1])
    points.append((x, y))

left = right = straight = 0

for j in range(1, n):
    a = points[j - 1]
    b = points[j]
    c = points[(j + 1) % n]

    # test orientare ca la prima problema
    det = (b[0] - a[0]) * (c[1] - b[1]) - (b[1] - a[1]) * (c[0] - b[0])

    if det > 0:
        left += 1
    elif det < 0:
        right += 1
    else:
        straight += 1

print(f"{left} {right} {straight}")

