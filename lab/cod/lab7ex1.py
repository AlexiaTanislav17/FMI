def pozitie_fata_de_cerc(A, B, C, D):
    # patratele coordonatelor
    A_sq = A[0] * A[0] + A[1] * A[1]
    B_sq = B[0] * B[0] + B[1] * B[1]
    C_sq = C[0] * C[0] + C[1] * C[1]
    D_sq = D[0] * D[0] + D[1] * D[1]
    
    det = (
        A[0] * (B[1] * C_sq + C[1] * D_sq + B_sq * D[1] - 
                D[1] * C_sq - B[1] * D_sq - B_sq * C[1]) -
        A[1] * (B[0] * C_sq + C[0] * D_sq + D[0] * B_sq - 
                D[0] * C_sq - B[0] * D_sq - C[0] * B_sq) +
        A_sq * (B[0] * C[1] + C[0] * D[1] + D[0] * B[1] - 
                D[0] * C[1] - B[0] * D[1] - C[0] * B[1]) -
        (B[0] * C[1] * D_sq + C[0] * D[1] * B_sq + B[1] * C_sq * D[0] - 
         D[0] * C[1] * B_sq - D[1] * C_sq * B[0] - C[0] * B[1] * D_sq)
    )
    
    if det < 0:
        return "OUTSIDE"
    elif det > 0:
        return "INSIDE"
    return "BOUNDARY"

def main():
    xA, yA = map(int, input().split())
    xB, yB = map(int, input().split())
    xC, yC = map(int, input().split())
    
    m = int(input())
    l=[]
    for i in range(m):
        x, y = map(int, input().split())
        result = pozitie_fata_de_cerc((xA, yA), (xB, yB), (xC, yC), (x, y))
        l.append(result)
    
    for elem in l:
        print(elem)

main()


