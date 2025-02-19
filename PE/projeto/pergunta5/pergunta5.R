set.seed(2126)
ttest = function(z){
  2*z[1]/(sqrt(sum(z^2)-z[1]^2))
}
sample_generator <- function(x){
  result <- c()
  for (i in 1:x){
    result[i] <- ttest(rnorm(5))
  }
  return(result)
}
percentages = c()
for (i in 1:150){
  sample = sample_generator(130)
  smaller_than_minus_0.9 = length(sample[sample <= -0.9])
  percentages[i] <- (smaller_than_minus_0.9/130)
}
(pt(-0.9,4)  - mean(percentages))*100