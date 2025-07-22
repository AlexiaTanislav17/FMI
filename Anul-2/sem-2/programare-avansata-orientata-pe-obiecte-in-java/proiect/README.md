# Magazin Online de Plante
 
Este simulat un magazin online de plante. 
Aplicatia permite gestionarea unui catalog de plante, 
a cosurilor de cumparaturi ale utilizatorilor si a comenzilor plasate.

---

## Actiuni

- Adaugarea unei plante in catalog  
- Cautarea unei plante dupa nume  
- Afisarea tuturor plantelor 
- Sortarea plantelor dupa pret  
- Adaugarea unui produs in cos 
- Vizualizarea cosului
- Stergerea unui produs din cos  
- Calcularea totalului de plata  
- Finalizarea unei comenzi  
- Afisarea comenzilor trecute ale utilizatorilor

---

## Clase

- `Planta` - clasa abstracta de baza
- `PlantaReala`, `PlantaDecorativa` - clase care extind `Planta`
- `Adresa` - retine adresa la care e livrata comanda
- `Utilizator` - are informatii despre utilizator
- `CosCumparaturi` - gestioneaza lista de plante din cos
- `Comanda` - retine o comanda
- `ServiciuPlante` - clasa serviciu care gestioneaza catalogul, cosurile si comenzile
- `MainProiect` - clasa principala pentru rulare



