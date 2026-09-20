install.packages("qcc")
library(qcc)

erros <- c(1, 0, 0, 3, 1, 0, 0, 0, 0, 2, 1, 4, 1, 0, 0, 0, 2, 1, 0, 1, 0, 4, 1, 0, 2)
tamanho_amostra <- 20  # n = 20 encomendas por dia

carta_p <- qcc(
  data = erros,
  type = "p",
  sizes = tamanho_amostra,
  title = "Carta de Controlo p - Encomendas não conformes",
  xlab = "Dia de Estágio",
  ylab = "Proporção de Erros (p)"
)

summary(carta_p)