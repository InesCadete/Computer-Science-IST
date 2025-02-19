set.seed(2255)
sound_but_not_off <-function(x){
  if (2 %in% x & !(1 %in% x)){
    return(1)
  }
  else{
    return(0)
  }
}
result = 0
for (i in 1:150){
  result = result + sound_but_not_off(sample((1:10),9,prob=(1:10)/55))
}
print(result/150)