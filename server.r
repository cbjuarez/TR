library(ellipse)
library(mvtnorm)
# Define the server code
server <- function(input, output){
output$plot <- renderPlot({
hor <- -qnorm(input$BR / 100)
ver <- -qnorm(input$SR / 100)
sig <- matrix( c( 1, input$V, input$V, 1), ncol = 2)

true_positives <- round(pmvnorm( c(ver, hor), c(Inf, Inf), sigma = sig) * 100, 1)
false_positives <- round(pmvnorm( c(ver, -Inf), c(Inf, hor), sigma = sig) * 100, 1)
false_negatives <- round(pmvnorm( c(-Inf, hor), c(ver, Inf), sigma = sig) * 100, 1)
true_negatives <- round(pmvnorm( c(-Inf, -Inf), c(ver, hor), sigma = sig) * 100, 1)

plot(0, type = "n", xlab = "Test Score\n(% Rejected)", 
ylab="Job Performance (% Unqualified)", col.axis=NA, fg=NA, lwd=3, bty="n", 
font.lab=2, xlim = c(-3, 3), ylim=c(-3, 3), main="Hits,  Misses, and False Alarms", sub = paste("Hiring Success Rate =", round(100 * true_positives / (true_positives + false_positives)), "%"))        
polygon(c(-4, -4, ver, ver), c(-4, hor, hor, -4), col = rgb(0, 0, 1, .25), border = NA)
polygon(c(ver, ver, 4, 4), c(hor, 4, 4, hor), col = rgb(0, 1, 0, .25), border = NA)
polygon(c(ver, ver, 4, 4), c(hor, -4, -4, hor), col = rgb(1, 0, 0, .25), border = NA)
polygon(c(-4, -4, ver, ver), c(hor, 4, 4, hor), col = rgb(1, 1, 0, .325), border = NA)
polygon(c(-4, -4, 0, ellipse(input$V)[, 1], 0, 4, 4), c(-4, 4, 4, ellipse(input$V)[, 2], 4, 4, -4), col = "white", border = NA)
abline(h = hor, v = ver, col="red", lwd = 3, lty = 3)
text(2.6, 2.6, paste(true_positives, "%"))
text(-2.6, -2.6, paste(true_negatives, "%"))
text(-2.6, 2.6, paste(false_negatives, "%"))
text(2.6, -2.6, paste(false_positives, "%"))
})}