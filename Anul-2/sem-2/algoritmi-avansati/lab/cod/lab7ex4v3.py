def calculeaza_limite(semiplane):
    stanga, dreapta, sus, jos = [], [], [], []

    for a, b, c in semiplane:
        if a == 0 and b != 0:
            y = -c / b
            if b > 0:
                sus.append(y)    
            else:
                jos.append(y)    
        elif b == 0 and a != 0:
            x = -c / a
            if a > 0:
                dreapta.append(x)  
            else:
                stanga.append(x)  
    
    return stanga, dreapta, jos, sus

def punct_in_dreptunghi(p, st, dr, js, ss):
    x, y = p
    x_min = max([val for val in st if val < x], default=None)
    x_max = min([val for val in dr if val > x], default=None)
    y_min = max([val for val in js if val < y], default=None)
    y_max = min([val for val in ss if val > y], default=None)

    if None in (x_min, x_max, y_min, y_max):
        return False, None
    
    aria = (x_max - x_min) * (y_max - y_min)
    return True, aria

def main():
    rezultate = []
    
    n = int(input())
    semiplane = [tuple(map(int, input().split())) for i in range(n)]
    stanga, dreapta, jos, sus = calculeaza_limite(semiplane)
    
    m = int(input())
    for i in range(m):
        punct = tuple(map(float, input().split()))
        ok, arie = punct_in_dreptunghi(punct, stanga, dreapta, jos, sus)
        if ok:
            rezultate.append("YES")
            rezultate.append(f"{arie:.6f}")
        else:
            rezultate.append("NO")
    
    print('\n'.join(rezultate))

main()
