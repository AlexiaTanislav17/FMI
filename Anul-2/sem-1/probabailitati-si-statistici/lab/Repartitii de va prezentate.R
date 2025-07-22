# Repartitii de v.a.


# avem 4 tipuri de functii:
# cele care incep cu d
# cele care incep cu p
# cele care incep cu r
# cele care incep cu q


#1. d+nume_repartitie = functie de masa(caz discret)/functia de densitate de probabilitate(caz continuu)
   # primul argument reprezinta vectorul de valori in care vrem sa evaluam functia, iar pe urmatoarele pozitii
   # sunt parametrii repartitiei, pusi in ordine
   # dgeom(x,p)
   # dbinom(x,n,p)
   dbinom(3,5,0.4) #probabilitatea sa reusesc de 3 ori din 5 incercari cu probabilitatea de succes de 0.4
   #P(X=3)
   dbinom(0:5,5,0.4)  #n=5  si p=0.4   si   0.5 e punctul in care vreau sa evaluez
   plot(0:10,dbinom(0:10,5,0.4), col="red")  #deseneaza puncte
   lines(0:10,dbinom(0:10,5,0.4), col="red")   #uneste punctele

   plot(0:10,dbinom(0:10,5,0.9), col="red")
   lines(0:10,dbinom(0:10,5,0.9), col="red")

   plot(0:10,dbinom(0:10,5,0.1), col="red")
   lines(0:10,dbinom(0:10,5,0.1), col="red")

   plot(0:100,dbinom(0:100,100,0.4), col="red")
   lines(0:100,dbinom(0:100,100,0.4), col="red")

   # punctul maxim este n*p care este media 


   # repartitie exponentiala 
   # dexp(x,lambda)
   dexp(3,1) #NU mai e o probabilitate
   t <- seq(0.001,10,0.001)  #densitatea exponentialei
   plot(t,dexp(t,1),ylim=c(0,0.05))   #ylim e un zoom in pe o anumita zona de pe axa Oy
   plot(t,dexp(t,5), type="l")  #type="l" iti face linia mai subtire de la grafic
   lines(t,dexp(t,1/2), col="red")
   lines(t,dexp(t,1),col="blue")


#2. p+nume_repartitie = functia de repartitie
    # primul argument reprezinta vectorul de valori in care vrem sa evaluam functia, iar pe urmatoarele pozitii
    # sunt parametrii repartitiei, pusi in ordine
    # pbinom(x,n,p)
    # P(X<=x)
   pbinom(3,5,0.4) #Probabilitatea sa obtinem cel mult 3 succese din 5 incercari cu probabilitatea de succes de 0.4
   t <- seq(0,8,0.001)
   plot(t,pbinom(t,5,0.4))
   plot(t,pexp(t,1), type="l")
   lines(t,pexp(t,1/2), col="red")
   lines(t,pexp(t,5),col="blue")
   
   
   
#3. r+nume_repartitie = genereaza valori din acel tip de repartitie
   # rbinom(nr,n,p)
   # nr-numarul de valori pe care le vrem generate
   # r vine de la random
   
   set.seed(15129) # trebuie neaparat rulat impreuna cu rbinom (linia urm)
   rbinom(3,5,0.4) # genereaza 3 valori dintr-o v.a. repartizata binomial cu parametrii 5 si 0.4
   y <- rbinom(10^6,5,0.4)
   hist(y)
   
   rexp(3,1) # genereaza 3 valori dintr-o v.a. repartizata exponential de parametru 1
   y1 <-rexp(10^6,1)
   hist(y1,freq=F)
   t <- seq(0.001,8,0.001)
   lines(t,dexp(t,1),col="magenta")
   # daca generez un esantion mic, potrivirea nu mai e la fel de spectaculoasa
   y2 <-rexp(100,1)
   hist(y2,freq=F)
   t <- seq(0.001,8,0.001)
   lines(t,dexp(t,1),col="magenta")
   # daca rulam de mai multe ori liniile 73 - 76 o sa ne dea rezultate dif nu f precise
   
   
   
   #Reprezentari grafice de functii
   #Functia densitate de probabilitate a repartitiei normale
   t <- seq(-6,6,0.001)
   plot(t,dnorm(t,0,1))
   
   plot(t,dexp(t,2),ylim=c(0,0.))
   #ATENTIE: IN R parametrii normalei sunt media si abaterea medie standard
   y <- rnorm(100,0,1)
   
   poz <- y[y>0]
   prob_nr_poz <- length(poz)/10^2
   neg <- y[y<0]
   prob_nr_neg <- length(neg)/10^2
   
   y <- rnorm(1000000,0,1)
   
   length(y[(y>-3)&(y<3)])
  
   lines(t,dnorm(t,0,1))
   plot(t,dnorm(t,3,1),col="magenta",xlim=c(-8,8),ylim=c(0,1))
   lines(t,dnorm(t,3,4), col=2)
   lines(t,dnorm(t,3,0.5), col=3)
   lines(t,dnorm(t,3,2), col=5)
   lines(t,dnorm(t,3,0.5),col=1)
   
   z <- rnorm(1000,2,1)
   length(z[z< -2])
   
   plot(t,dnorm(t,0,1),col="magenta",ylim=c(0,1.8))
   for (i in c(0.25,0.5,0.3,0.9,1.3,2)) lines(t,dnorm(t,0,i), col=i*20)
   
   
   
   #phi(1.35)
   #in r parametrii de la normala sunt media si abaterea de la media patratica (sigma, nu sigma patrat)
   pnorm(1.35, 0, 1)
   
   #test paternitate exercitiu
   1-pnorm(290, 270, 10) + pnorm(240, 270, 10)
   
   
   
   
#4. q+nume_repartitie = functia cuantila
   # un fel de inversa a functiei de repartitie
   
   qbinom(0.5, 5, 0.4)
   qnorm(0.95)
   
   #test paternitate
   qnomr(0.9987,0,1 )
   qnomr(0.9772, 0,1)
   
   
   #un alt ex din seminar 10
   qnorm(0.9, 8,3)
   
   
   
   
   
   
   
   
   