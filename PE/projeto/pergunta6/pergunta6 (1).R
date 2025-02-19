set.seed(1948)
# set.seed(1973)
soma_amostras <- c() #gerar 1000 amostras com soma das 30 componentes
for (i in 1:1000){
  soma_amostras[i] <- sum(rexp(30,1/4)) #valor esperado = 1/rate
}
numero_de_ocorrencias = length(soma_amostras[soma_amostras>90])
abs((1-pgamma(90,30,1/4)) - numero_de_ocorrencias/1000)*100