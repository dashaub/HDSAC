# Copyright (C) 2018 David Shaub
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

N <- 0
k <- 0
# Starting values for the hyperparameter of our beta distribution prior
a <- 4
b <- 2
x <- seq(0, 1, length = 1000)
betaPrior <- dbeta(x, a, b)

# plotting parameters
lwd <- 4
size <- 480 * 5
cols <- c("red", "black", "blue")
cols <- c("#b3e2cd", "#fdcdac", "#cbd5e8")

# 
p <- 0.4
num <- 50
set.seed(50)
numPos <- round(num * p)
# Guarantee a population proportion matching expected p but with permuted order
outcome <- c(rep(1, numPos), rep(0, num - numPos))
outcome <- sample(outcome, size = num)

for(i in 1:50){
  # Bayesian updating rules for Beta-Binomial model with a new observation
  k <- k + outcome[i]
  N <- N + 1
  a <- a + k
  b <- b + N - k
  hx <- dbeta(x, a, b)

  # Plot the current trial
  subText <- paste0("Beta distribution with α = ", a, ", β = ", b)
  mainText <- paste0("Trial ", i)
  mainText <- paste0(mainText, "\n", subText)
  fileName <- paste0(1000 + i, ".png")
  png(filename = fileName, width = size, height = size, res = 300)
  plot(x, betaPrior, lwd = lwd, type = "l", col = cols[1],
       xlab = "θ", ylab = "P(θ)", ylim = c(0, 30))
  title(main = mainText)
  lines(x, hx, col = cols[3], lwd = lwd)
  legend("topright", legend = c("Prior", "Empirical", "Posterior"),
         lwd = lwd, col = cols)
  abline(v = k / N, lwd = lwd, col = cols[2])
  dev.off()
}
