set.seed(123)  # pt aceleasi val random cand dai run
n <- 10  # nr de etape
lambda <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)  # parametrii lambda pentru fiecare etapa
alpha <- c(0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.05)  # prob de trecere la etapa urm
# alfa de i este prob ca persoana A sa treaca de la etapa i la etapa i+1
# 1-alfa de i este prob ca persoana A sa se opreasca dupa etapa i
nrSim <- 1000000  # nr de simulari


################### cerinta 1 #########################

simulate_T <- function(n, lambda, alpha) {
  total_time <- 0
  for (i in 1:n) {
    time <- rexp(1, rate = lambda[i])  # timp pentru etapa i
    total_time <- total_time + time
    if (runif(1) > alpha[i]) {  # alege random un nr intre 0 si 1
      break  # stop dupa etapa i daca nr ales este mai mare decat prob alfa de i
    }
  }
  return(total_time)
}

T_values <- replicate(nrSim, simulate_T(n, lambda, alpha))
# aplica functia/operatia simulate_T de 10^6 ori pt T
mean_T <- mean(T_values)  # media ar a timpilor totali din simulari

# reprezentare grafica
hist(T_values, breaks = 50, main = "Distributia lui T", xlab = "Timpul total T",ylab="Frecventa", col = "darkseagreen1")
# daca freq=false arata probabilitatile
# breaks = nr bins/cosuri/drept alea verzi
abline(v = mean_T, col = "purple1", lwd = 2)
# linia mov pt media lui T
legend("topright", legend = paste("E(T) = ", round(mean_T, 2)), col = "purple1", lwd = 2)
# legenda pt linia mediei lui T
print(paste("Valoarea aproximata a lui E(T) =", mean_T))



################### cerinta 2 #########################

exact_ET <- 0
for (i in 1:n) {
  prod_alpha <- if (i == 1) 1 else prod(alpha[1:(i-1)])  # produsul alpha1 * alpha2 * ... * alpha(i-1)
  exact_ET <- exact_ET + prod_alpha * (1 / lambda[i])
}

print(paste("Valoarea exacta a lui E(T) =", exact_ET))
print(paste("Dif intre valoarea exacta si cea simulata =", abs(exact_ET - mean_T)))



################### cerinta 3 #########################

simulate_T_final <- function(n, lambda, alpha) {
  total_time <- 0
  completed <- TRUE  # presupun ca finalizeaza activitatea
  for (i in 1:n) {
    time <- rexp(1, rate = lambda[i])  # timp pentru etapa i
    total_time <- total_time + time
    if (runif(1) > alpha[i]) {  
      completed <- FALSE  # nu a finalizat activitatea
      break
    }
  }
  return(completed)  # returneaza TRUE daca a finalizat, FALSE altfel
}

comp <- replicate(nrSim, simulate_T_final(n, lambda, alpha))
prob_final <- mean(comp)  # probabilitatea de finalizare
print(paste("Probabilitatea de finalizare a activitatii =", prob_final))



################### cerinta 4 #########################

sigma <- 5  # valoarea lui sigma
# este ales mai mare sa acopere toate cazurile, deci prob o sa fie 1
T_values_sigma <- T_values[comp]
# filtreaza T_values folosind vectorul logic comp
# ia elementele de pe aceleasi pozitii iar daca in al doilea vector e true
# atunci pastreaza timpul lui T
prob_sigma <- mean(T_values_sigma <= sigma)
# compara fiecare T cu sigma is face med ar din val de true false <= sigma
print(paste("Probabilitatea ca T <= sigma:", prob_sigma))



################### cerinta 5 #########################

min_T <- min(T_values_sigma)
max_T <- max(T_values_sigma)

print(paste("Timpul minim de finalizare=", min_T))
print(paste("Timpul maxim de finalizare=", max_T))

# reprezentare grafica a timpilor de finalizare
hist(T_values_sigma, breaks = 50, main = "Repartitia timpilor de finalizare", xlab = "Timpul total T", ylab = "Frecventa", col = "darkseagreen1")
abline(v = mean(T_values_sigma), col = "purple1", lwd = 2)  # linie pentru medie
legend("topright", legend = paste("Media =", round(mean(T_values_sigma), 2)), col = "purple1", lwd = 2)


################### cerinta 6 #########################

simulate_stop_stage <- function(n, lambda, alpha) {
  for (i in 1:n) {
    time <- rexp(1, rate = lambda[i])  
    if (runif(1) > alpha[i]) {  # daca se opreste dupa etapa i
      return(i)  # returneaza etapa la care s-a oprit
    }
  }
  return(n)  # daca a trecut prin toate etapele
}
# functia care iti arata la ce etapa s-a oprit A

stop_stages <- replicate(nrSim, simulate_stop_stage(n, lambda, alpha))
# etapele la care s-a oprit A vector

prob_stop_before_k <- sapply(1:n, function(k) {
  mean(stop_stages < k)  # prob ca A sa se opreasca inainte de k
})
# se aplica pt toate k-urile de la 1 la n

# reprezentare grafica 
plot(1:n, prob_stop_before_k, type = "b", col = "purple1", 
     xlab = "Etapa k", ylab = "Prob de op inainte de k",
     main = "Probabilitatea de oprire inainte de etapa k")
grid()





