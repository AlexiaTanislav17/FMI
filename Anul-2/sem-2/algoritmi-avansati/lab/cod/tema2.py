import random
import math

# parametrii
functie = lambda x: -x**2 + x + 2     # polinomul de maximizat
a, b = -1, 2                          # domeniu
precizie = 6                         # nr zecimale
dim_pop = 20                         # populatie
pc = 0.25                            # probabilitate crossover
pm = 0.01                            # probabilitate mutatie
nr_etape = 50                        # nr generatii

# codificare binarra
def nr_biti(a, b, precizie):
    nr_valori = (b - a) * (10 ** precizie)
    return math.ceil(math.log2(nr_valori))

lungime_cromozom = nr_biti(a, b, precizie)

def genereaza_populatie(dim, lungime):
    return [random.choices([0, 1], k=lungime) for _ in range(dim)]

def binar_la_real(binar, a, b):
    z = int("".join(map(str, binar)), 2)
    max_z = 2**len(binar) - 1
    return a + (b - a) * z / max_z

def fitness(populatie, functie, a, b):  #apical functia pt fiecare cromozom transofrmat in nr real
    return [functie(binar_la_real(crom, a, b)) for crom in populatie]

def selectie_ruleta(populatie, fit):   # fitnes mare => probabilitate mare de a fi selectat
    total = sum(fit)
    selectii = []
    for _ in populatie: #pt fiecare individ din populatia curenta selectez un individ nou pt selectie (in final tot dim pop indvizizi o sa fie)
        r = random.uniform(0, total)
        s = 0  # ne spune pe ce "felie" a rotii am ajuns
        for i, f in enumerate(fit):
            s += f
            if s >= r: #simulam ruleta daca suma fitnesurilor depaseste un numar random =r
                selectii.append(populatie[i][:])  # adaugam copie la noua populateu
                break
    return selectii

# def crossover(populatie, pc):
#     copii = []  # copii dupa incrucisarei
#     random.shuffle(populatie)  #amestec ca sa nu combin mereu aceasi indivizi
#     for i in range(0, len(populatie) - 1, 2):
#         p1, p2 = populatie[i], populatie[i+1]
#         if random.random() < pc: # facem incrucisare daca nr e mai mic decat pc
#             punct = random.randint(1, len(p1) - 1)
#             copil1 = p1[:punct] + p2[punct:]
#             copil2 = p2[:punct] + p1[punct:]
#             copii.extend([copil1, copil2])
#         else:
#             copii.extend([p1[:], p2[:]])  # parintii trec in populatie nemodificati
#     if len(populatie) % 2 == 1:
#         copii.append(populatie[-1])
#     return copii

def crossover(populatie, pc):
    copii = []  # copii dupa incrucisarei
    copii_select = [(i,c) for i,c in enumerate(populatie) if random.random() < pc]  # cromo care o sa fie incruscistae
    for i in range(len(populatie)):
        if i not in [c[0] for c in copii_select]:
            copii.append(populatie[i][:])
    copii_select = [c[1] for c in copii_select]  # selectam cromozomii
    random.shuffle(copii_select)  #amestec ca sa nu combin mereu aceasi indivizi
    for i in range(0, len(copii_select) - 1, 2):
        p1, p2 = copii_select[i], copii_select[i+1]
        punct = random.randint(1, lungime_cromozom - 1)
        copil1 = p1[:punct] + p2[punct:]
        copil2 = p2[:punct] + p1[punct:]
        copii.extend([copil1, copil2])
    if len(populatie) % 2 == 1:
        copii.append(copii_select[-1])
    return copii


def mutatie(populatie, pm):   # fiecare bit are probabilitatea pm de a fi inversat
    for crom in populatie:
        for i in range(len(crom)):
            if random.random() < pm:
                crom[i] = 1 - crom[i]

def elitism(populatie, fit):  # selectam cel mai bun individ
    max_fit = max(fit)
    index = fit.index(max_fit)
    return populatie[index][:], max_fit   # il copiem in generatia urmatoare

# algoritm principal
def algoritm_genetic():
    populatie = genereaza_populatie(dim_pop, lungime_cromozom)  # prima generatie/populatie
    with open("Evolutie.txt", "w", encoding="utf-8") as f:
        for gen in range(nr_etape):
            fit = fitness(populatie, functie, a, b)
            elit, f_elit = elitism(populatie, fit)

            if gen == 0:  # pt prima gneneratie detaliam
                f.write(f"Generatia {gen+1} (detaliata):\n")
                for i, crom in enumerate(populatie):
                    x = binar_la_real(crom, a, b)
                    f.write(f"Cromozom {i+1:2d}: {''.join(map(str, crom))}, x={x:.6f}, f(x)={fit[i]:.6f}\n")
                f.write("\n")
            else:
                best = max(fit)   # the goat din generatia actuala
                avg = sum(fit) / len(fit)  #cat de buna e populatia in anasmblu
                f.write(f"Generatia {gen+1}: max fitness = {best:.6f}, fitness mediu = {avg:.6f}\n")

            selectie = selectie_ruleta(populatie, fit)  # indvizii cu fitnessul mai mare au probabilitate mai amre de a fi dusi mai departe
            copii = crossover(selectie, pc) # incruscisam oamenii selectati
            mutatie(copii, pm)  # dupa ce sunt incrucisati facem mutatie 

            # elitism: inlocuim un individ aleator cu cel mai bun
            copii[0] = elit
            populatie = copii  # noua generatie devine populatia curenta

# execuie
if __name__ == "__main__":
    algoritm_genetic()
    print("algoritmul genetic a fost rulat")
