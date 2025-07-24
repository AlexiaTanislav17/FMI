# p q r 
# t

def orientare(xp, yp, xq, yq, xr, yr):
    det = (xq - xp) * (yr - yp) - (xr - xp) * (yq - yp)
    
    if det > 0:
        return "LEFT"
    elif det < 0:
        return "RIGHT"
    else:
        return "TOUCH"



t = int(input())
l = []

for elem in range(t):
    xp, yp, xq, yq, xr, yr = map(int, input().split())
    rezultat = orientare(xp, yp, xq, yq, xr, yr)
    l.append(rezultat)

for elem in l:
    print(elem)






















