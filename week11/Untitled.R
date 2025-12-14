coverage <- scan("/Users/cmdb/qb25-answers/week11/coverage10x.txt")

zero_frac <- mean(coverage == 0)
poisson_zero <- exp(-3)
hist(
  coverage,
  breaks = 50,
  probability = TRUE,
  col = "pink",
  main = "Genome Coverage 3×",
  xlab = "Coverage depth",
  ylab = "Density"
)
xs <- 0:max(coverage)
lines(xs, dpois(xs, lambda = 3), col = "black", lwd = 2)
lines(xs, dnorm(xs, mean = 3, sd = sqrt(3)), col = "purple", lwd = 2)
legend(
  "topright",
  legend = c("Observed", "Poisson (λ=3)", "Normal (μ=3, σ=1.73)"),
  col = c("white", "black", "purple"),
  lwd = c(10, 2, 2),
  bty = "n"
)
#answer for question 1.4 
mean(coverage)
mean(coverage == 0)
png("ex1_3x_cov.png")
dev.off()

##code for 10x
coverage <- scan("/Users/cmdb/qb25-answers/week11/coverage10x.txt")

zero_frac <- mean(coverage == 0)
poisson_zero <- exp(-10)
hist(
  coverage,
  breaks = 50,
  probability = TRUE,
  col = "pink",
  main = "Genome Coverage 10x",
  xlab = "Coverage depth",
  ylab = "Density"
)
xs <- 0:max(coverage)
lines(xs, dpois(xs, lambda = 10), col = "black", lwd = 2)
lines(xs, dnorm(xs, mean = 10, sd = 3.16), col = "purple", lwd = 2)
legend(
  "topright",
  legend = c("Observed", "Poisson (λ=10)", "Normal (μ=10, σ=3.16)"),
  col = c("white", "black", "purple"),
  lwd = c(10, 2, 2),
  bty = "n"
)
mean(coverage == 0)
png("ex1_10x_cov.png")

#below is for 30x
coverage <- scan("/Users/cmdb/qb25-answers/week11/coverage30x.txt")

zero_frac <- mean(coverage == 0)
poisson_zero <- exp(-10)
hist(
  coverage,
  breaks = 50,
  probability = TRUE,
  col = "pink",
  main = "Genome Coverage 30x",
  xlab = "Coverage depth",
  ylab = "Density"
)
xs <- 0:max(coverage)
lines(xs, dpois(xs, lambda = 30), col = "black", lwd = 2)
lines(xs, dnorm(xs, mean = 30, sd = 5.47), col = "purple", lwd = 2)
legend(
  "topright",
  legend = c("Observed", "Poisson (λ=30)", "Normal (μ=30, σ=5.47)"),
  col = c("white", "black", "purple"),
  lwd = c(10, 2, 2),
  bty = "n"
)
mean(coverage == 0)
png("ex1_30x_cov.png")

#2.4 code 
dot -Tpng debruijn.dot -o ex2_digraph.png

#2.5 answer
One possible genome sequence would be ATTCTTATT

#2.6 answer 
To accurately reconstruct the sequences of the genome all the areas of the 
genome needs to be observed in the reads, indicating that complete coverage is required in all regions. 
It is also important to know the exact value of k-mer and its occurance to help create a full and accurate Bruijn graph and prevent ambiguity. 
LAstly, the kmers cannot be short and need to be long enough to help adress any repeats in the genome. 
