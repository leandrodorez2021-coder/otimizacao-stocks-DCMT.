library(forecast)
library(ggplot2)

dados_cimento <- ts(c(320, 280, 243, 224, 198, 277, 320, 331, 404), start = 1, frequency = 1)

modelo_holt <- holt(dados_cimento, h = 3)

autoplot(modelo_holt) +
  scale_x_continuous(breaks = 1:12) +
  labs(
    title = "Previsão Estatística da Procura - Cimento PragmaFlex 40 (Modelo de Holt)",
    x = "Horizonte Temporal (Meses)",
    y = "Volume de Saídas (Sacos)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 13, hjust = 0.5),
    panel.grid.minor = element_blank()
  )


summary(modelo_holt)


autoplot(modelo_holt) +
  geom_segment(aes(x = 9, y = 404, xend = 10, yend = modelo_holt$mean[1]), 
               color = "blue", linewidth = 0.8) +
  scale_x_continuous(breaks = 1:12) +
  labs(
    title = "Previsão Estatística da Procura - Cimento PragmaFlex 40 (Modelo de Holt)",
    x = "Horizonte Temporal (Meses)",
    y = "Volume de Saídas (Sacos)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 13, hjust = 0.5),
    panel.grid.minor = element_blank()
  )