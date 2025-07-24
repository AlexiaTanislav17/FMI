def pozitie_fata_de_cerc(A, B, C, D):
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
    
    return det > 0  # adv daca e in cerc

def verifica_muchie_legala(A, B, C, D):
    return not pozitie_fata_de_cerc(A, B, C, D)

def main():
    points = []
    for i in range(4):
        x, y = map(int, input().split())
        points.append((x, y))

    ac_legal = verifica_muchie_legala(points[0], points[1], points[2], points[3])
    bd_legal = verifica_muchie_legala(points[1], points[2], points[3], points[0])
    
    print(f"AC: {'LEGAL' if ac_legal else 'ILLEGAL'}")
    print(f"BD: {'LEGAL' if bd_legal else 'ILLEGAL'}")

main()



