def orientare(xp, yp, xq, yq, xr, yr):
    det = (xq - xp) * (yr - yp) - (xr - xp) * (yq - yp)
    
    if det > 0:
        return 1    # left
    elif det < 0:
        return -1   # right
    return 0        # touch

def pe_segment(xp, yp, xq, yq, xr, yr):
    # R pe PQ
    if (min(xp, xq) <= xr <= max(xp, xq) and 
        min(yp, yq) <= yr <= max(yp, yq) and
        orientare(xp, yp, xq, yq, xr, yr) == 0):
        return True
    return False

def verifica_pozitie(poligon, xq, yq):
    n = len(poligon)
    # pct pe margine
    for i in range(n):
        j = (i + 1) % n
        if pe_segment(poligon[i][0], poligon[i][1], 
                     poligon[j][0], poligon[j][1], xq, yq):
            return "BOUNDARY"
    
    xm = max(x for x, _ in poligon) + 1000  # pct M 
    ym = yq  
    
    intersectii = 0
    for i in range(n):
        j = (i + 1) % n
        xi, yi = poligon[i]
        xj, yj = poligon[j]
        
        # MQ intersecteaza latura ij
        if (yi > yq) != (yj > yq):  # latura traverseaza linia orizontala
            # x-ul intersectiei
            if xi == xj:  # latura verticala
                if xq <= xi:  # intersectia e ok
                    intersectii += 1
            else:
                # x-ul intersectiei cu ecuatia dreptei
                x_intersectie = xi + (yq - yi) * (xj - xi) / (yj - yi)
                if xq <= x_intersectie:  # intersectia e ok
                    intersectii += 1
    
    return "INSIDE" if intersectii % 2 == 1 else "OUTSIDE"


l = []
n = int(input())  # nr vf poligon
poligon = []
for vf in range(n):
    x, y = map(int, input().split())
    poligon.append((x, y))

m = int(input()) #pct test
for pct in range(m):
    x, y = map(int, input().split())
    rezultat = verifica_pozitie(poligon, x, y)
    l.append(rezultat)

for elem in l:
    print(elem)
