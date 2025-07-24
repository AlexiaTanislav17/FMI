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


def intersecteaza(p1, q1, p2, q2):
    o1 = orientare(p1, q1, p2)
    o2 = orientare(p1, q1, q2)
    o3 = orientare(p2, q2, p1)
    o4 = orientare(p2, q2, q1)
    
    if o1 != o2 and o3 != o4:
        return True
    
    if o1 == "TOUCH" and pe_segment(p1, q1, p2): return True
    if o2 == "TOUCH" and pe_segment(p1, q1, q2): return True
    if o3 == "TOUCH" and pe_segment(p2, q2, p1): return True
    if o4 == "TOUCH" and pe_segment(p2, q2, q1): return True
    
    return False


def verifica_intersectii(poligon1, poligon2):
    n1, n2 = len(poligon1), len(poligon2)
    
    for i in range(n1):
        for j in range(n2):
            if intersecteaza(poligon1[i], poligon1[(i + 1) % n1],
                           poligon2[j], poligon2[(j + 1) % n2]):
                return True
    return False





t = int(input())
rezultate = []
for i in range(t):
    n1 = int(input())
    poligon1 = []
    for _ in range(n1):
        x, y = map(int, input().split())
        poligon1.append((x, y))

    n2 = int(input())
    poligon2 = []
    for _ in range(n2):
        x, y = map(int, input().split())
        poligon2.append((x, y))

    if verifica_intersectii(poligon1, poligon2):
        rezultate.append("YES")
    else:
        rezultate.append("NO")

for rezultat in rezultate:
    print(rezultat)




