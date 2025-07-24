from itertools import combinations

def punct_intersectie(a1, b1, c1, a2, b2, c2):
    if a1*b2 == a2*b1:  # linii paralele/identice
        return None
    
    if a1 == 0:  # prima linie e orizontala
        y = -c1/b1
        a = a2
        x = -(b2*y + c2)/a2
    elif a2 == 0:  # a2 a linie e orizontala
        y = -c2/b2
        a =a1
        x = -(b1*y + c1)/a1
    else:  # amblee verticale
        return None
    
    return (x, y)

def punct_in_dreptunghi(point, rect_points):
    x, y = point
    x_coords = [p[0] for p in rect_points]
    y_coords = [p[1] for p in rect_points]
    
    x_min, x_max = min(x_coords), max(x_coords)
    y_min, y_max = min(y_coords), max(y_coords)
    
    # pct trb sa fie in interiorul dreptunghiului
    return x_min < x < x_max and y_min < y < y_max

def aria_dreptunghi(points):
    x_coords = [p[0] for p in points]
    y_coords = [p[1] for p in points]
    width = max(x_coords) - min(x_coords)
    height = max(y_coords) - min(y_coords)
    return width * height

def dreptunghi_interesant(points, semiplanes):
    if len(points) != 4:
        return False
        
    # formeaza un dreptunghi?
    x_coords = sorted(list(set([p[0] for p in points])))
    y_coords = sorted(list(set([p[1] for p in points])))
    if len(x_coords) != 2 or len(y_coords) != 2:
        return False
    
    return True

def main():
    l=[]
    n = int(input())
    semiplanes = []
    for i in range(n):
        a, b, c = map(int, input().split())
        semiplanes.append((a, b, c))
    
    # toate punctele de intersectie
    puncte_de_intersectie = set()
    for i, j in combinations(range(n), 2):
        point = punct_intersectie(semiplanes[i][0], semiplanes[i][1], semiplanes[i][2],
                                    semiplanes[j][0], semiplanes[j][1], semiplanes[j][2])
        if point:
            puncte_de_intersectie.add(point)
    
    m = int(input())
    for i in range(m):
        x, y = map(float, input().split())
        point = (x, y)
        
        # toate dreptunghiurile
        min_area = float('inf')
        found = False
        
        for rect_points in combinations(puncte_de_intersectie, 4):
            if dreptunghi_interesant(rect_points, semiplanes):
                if punct_in_dreptunghi(point, rect_points):
                    found = True
                    min_area = min(min_area, aria_dreptunghi(rect_points))
        
        if found:
            l.append("YES")
            l.append(f"{min_area:.6f}")
        else:
            l.append("NO")
        
    for elem in l:
        print(elem)


main()



