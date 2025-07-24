def tip_semiplan(n, coeficienti):
    # limite x si y
    x_min, x_max = float('-inf'), float('inf')
    y_min, y_max = float('-inf'), float('inf')
    
    for a, b, c in coeficienti:
        if a != 0:  # semiplan vertical (x = constant)
            if a > 0:
                x_max = min(x_max, -c/a)
            else:
                x_min = max(x_min, -c/a)
        else:  # semiplan orizontal (y = constant)
            if b > 0:
                y_max = min(y_max, -c/b)
            else:
                y_min = max(y_min, -c/b)
    
    # tipu de intersectie
    if x_min > x_max or y_min > y_max:
        return "VOID"
    elif x_min > float('-inf') and x_max < float('inf') and \
         y_min > float('-inf') and y_max < float('inf'):
        return "BOUNDED"
    else:
        return "UNBOUNDED"


def main():
    n = int(input())
    coeficienti = []
    for i in range(n):
        a, b, c = map(int, input().split())
        coeficienti.append((a, b, c))
    
    rezultat = tip_semiplan(n, coeficienti)
    print(rezultat)


main()



