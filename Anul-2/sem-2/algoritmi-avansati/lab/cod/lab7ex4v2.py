def determina_limite(semiplane):
    left_bounds = []  
    right_bounds = [] 
    bottom_bounds = [] 
    top_bounds = []    

    for a, b, c in semiplane:
        if a == 0:
            if b > 0:
                top_bounds.append(-c / b)
            elif b < 0:
                bottom_bounds.append(-c / b)
        elif b == 0:
            if a > 0:
                right_bounds.append(-c / a)
            elif a < 0:
                left_bounds.append(-c / a)
        else:
            continue

    return left_bounds, right_bounds, bottom_bounds, top_bounds

def gaseste_dreptunghi_minim(x, y, left_bounds, right_bounds, bottom_bounds, top_bounds):
    valid_left = max([val for val in left_bounds if val < x], default=None)
    valid_right = min([val for val in right_bounds if val > x], default=None)
    valid_bottom = max([val for val in bottom_bounds if val < y], default=None)
    valid_top = min([val for val in top_bounds if val > y], default=None)

    if None in (valid_left, valid_right, valid_bottom, valid_top):
        return False, None

    aria = (valid_right - valid_left) * (valid_top - valid_bottom)
    return True, aria

def main():
    n = int(input())
    semiplane = []
    for i in range(n):
        a, b, c = map(int, input().split())
        semiplane.append((a, b, c))

    left_bounds, right_bounds, bottom_bounds, top_bounds = determina_limite(semiplane)

    m = int(input())
    for i in range(m):
        x, y = map(float, input().split())
        gasit, aria = gaseste_dreptunghi_minim(x, y, left_bounds, right_bounds, bottom_bounds, top_bounds)
        if gasit:
            print("YES")
            print(f"{aria:.6f}")
        else:
            print("NO")


main()
