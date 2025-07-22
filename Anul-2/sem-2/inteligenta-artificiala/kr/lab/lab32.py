class NodArbore:
    def __init__(self, _informatie, _parinte=None, _g = 0, _h = 0):
        self.informatie = _informatie
        self.parinte = _parinte
        self.g = _g
        self.h = _h
        self.f = self.g + self.h
    
    # [...g......========h==]
    # [...g...........===h==]
    def __lt__(self, elem):
        return (self.f < elem.f) or (self.f == elem.f and self.h < elem.h)

    def drumRadacina(self):
        # Return the path from the root to the current node
        nod = self
        l = []
        while nod:
            l.append(nod.informatie)
            nod = nod.parinte
        return l[::-1]

    def inDrum(self, infoNod):
        # Check if a node is in the path from the root to the current node
        nod = self
        while nod:
            if nod.informatie == infoNod:
                return True
            nod = nod.parinte
        return False

    def __str__(self):
        return str(self.informatie)

    def __repr__(self):
        # Return a string representation of the node and its path
        sirDrum = "->".join(map(str, self.drumRadacina()))
        return f"{self.informatie},cost {self.g} ({sirDrum})"
    

class Graf:
    def __init__(self, _start, _scopuri):
        self.start = _start
        self.scopuri = _scopuri

    def estimeaza_h(self, infoNod):
        if infoNod[2] == 0:
            return 2*(infoNod[0] + infoNod[1]) /(Graf.M-1)
        else:
            return 2*(infoNod[0] + infoNod[1]) /(Graf.M-1) - 1
    def scop(self, informatieNod):
        # Check if a node is a goal node
        return informatieNod in self.scopuri

    def succesori(self, nod):

        def test_conditie(m,c):
            return m==0 or m>=c

        # Generate successors for a given node
        lSuccesori = []
        # mal curent = mal cu barca
        if nod.informatie[2] == 1:
            canMalCurent = nod.informatie[0]
            misMalCurent = nod.informatie[1]
            canMalOpus = Graf.N - nod.informatie[0]
            misMalOpus = Graf.N - nod.informatie[1]
        else:
            canMalOpus = nod.informatie[0]
            misMalOpus = nod.informatie[1]
            canMalCurent = Graf.N - nod.informatie[0]
            misMalCurent = Graf.N - nod.informatie[1]

        maxMisBarca = min(Graf.M, misMalCurent)  #nr max de misionari care pot fi pusi in barca
        minMisBarca = 0
        for misBarca in range(minMisBarca, maxMisBarca + 1):

            if misBarca == 0:
                maxCanBarca = min(Graf.M, canMalCurent)
            else:
                maxCanBarca = min(Graf.M - misBarca, misBarca, canMalCurent)
            
            minCanBarca = 1 if misBarca == 0 else 0

            for canBarca in  range(minCanBarca, maxCanBarca +  1):
                misMalCurentNou = misMalCurent - misBarca
                canMalCurentNou = canMalCurent - canBarca
                misMalOpusNou = misMalOpus + misBarca
                canMalOpusNou = canMalOpus + canBarca

                if not test_conditie(misMalCurentNou, canMalCurentNou):
                    continue
                if not test_conditie(misMalOpusNou, canMalOpusNou):
                    continue
                if nod.informatie[2] == 1:
                    infoSuccesor = (canMalCurentNou, misMalCurentNou, 0)
                else:
                    infoSuccesor = (canMalOpusNou, misMalOpusNou, 1)

                if not nod.inDrum(infoSuccesor):
                    nodNou = NodArbore(infoSuccesor, nod)
                    lSuccesori.append(nodNou)
        return lSuccesori


def BF(gr, nsol):
    # Breadth-First Search algorithm
    coada = [NodArbore(gr.start)]
    while coada:
        nodCurent = coada.pop(0)
        if gr.scop(nodCurent.informatie):
            print("Solutie: ", end="")
            print(repr(nodCurent))
            nsol -= 1
            if nsol == 0:
                return
        coada += gr.succesori(nodCurent)



f = open("input.txt", "r")
continut = f.read().split()
Graf.N = int(continut[0])
Graf.M = int(continut[1])

# starea = (nr_canibali_mal_init, nr_misionari_mal_init, locatie_barca)
# locatie_barca = 1 (mal init); 0 (mal final)

m = [
[0, 3, 5, 10, 0, 0, 100],
[0, 0, 0, 4, 0, 0, 0],
[0, 0, 0, 4, 9, 3, 0],
[0, 3, 0, 0, 2, 0, 0],
[0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 4, 0, 5],
[0, 0, 3, 0, 0, 0, 0],
]

start = 0
scopuri = [4,6]
h=[0,1,6,2,0,3,0]
gr = Graf(m, start, scopuri, h)