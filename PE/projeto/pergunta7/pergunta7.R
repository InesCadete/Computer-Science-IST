library(stats4)
# values = c(4.37,4.3,5.15,5.11,5.15,4.66,6.15,5.72,5.87,5.64,4.05)

values = c(8.54,4.76,5.15,4.96,6.25,7.22,12.9,6.04,8.86,4.88,6.54,4.53,4.7,5.38,5.96,5.17,5.09,5.11)

f <- function(x,theta){
  log(theta)+(-theta-1)*log(x)+theta*log(4.5)
}
funcao_maxima_verosimilhanca <- function(lambda){
  -sum(f(values,lambda))
    } 
print(mle(funcao_maxima_verosimilhanca,start=list(lambda = 3.4)))
 #theta1 = 4.245097
 
 theta2 = 3.523137 

quartil_0.75 <-function(x){ #isto foi calculado resolvendo a equaçao integral_4^s theta*x^(-theta-1)*4^theta dx = 0.75
  (0.75/(4.5^x))^(-1/x)
}

abs(quartil_0.75(theta2)-quartil_0.75(3.4))