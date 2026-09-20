
library(ggplot2)
library(dplyr)


layout_armazem <- read.csv("layout_armazem.csv", sep = ";", dec = ",", header = TRUE)
saidas_mes     <- read.csv("saidas_mes.csv", sep = ";", dec = ",", header = TRUE)


colnames(layout_armazem) <- c("id_prateleira", "produto", "pos_x", "pos_y")
colnames(saidas_mes)     <- c("id_prateleira", "contagem_saidas")


layout_armazem$pos_x <- as.numeric(layout_armazem$pos_x)
layout_armazem$pos_y <- as.numeric(layout_armazem$pos_y)
saidas_mes$contagem_saidas <- as.numeric(saidas_mes$contagem_saidas)


saida_x <- 11.0  
saida_y <- 0.0  


dados_completos <- left_join(layout_armazem, saidas_mes, by = "id_prateleira")
dados_completos$contagem_saidas[is.na(dados_completos$contagem_saidas)] <- 0


mapa_final <- ggplot(dados_completos, aes(x = pos_x, y = pos_y)) +
  
  
  annotate("rect", xmin = 0, xmax = 22, ymin = 1.0, ymax = 4.0, fill = "#f5f5f5", alpha = 0.7) +
  annotate("text", x = 11, y = 2.5, label = "CORREDOR BETUMES / PASTILHAS / PERFIS", color = "grey40", fontface = "bold", size = 3.2) +
  
  annotate("rect", xmin = 0, xmax = 22, ymin = 6.0, ymax = 9.0, fill = "#f5f5f5", alpha = 0.7) +
  annotate("text", x = 11, y = 7.5, label = "CORREDOR BASES / MÓVEIS / LAVATÓRIOS", color = "grey40", fontface = "bold", size = 3.2) +
  
  annotate("rect", xmin = 0, xmax = 22, ymin = 11.0, ymax = 14.0, fill = "#f5f5f5", alpha = 0.7) +
  annotate("text", x = 11, y = 12.5, label = "CORREDOR SANITAS / TANQUES / TAMPOS / BIDÉS", color = "grey40", fontface = "bold", size = 3.2) +
  
 
  geom_tile(aes(fill = contagem_saidas), color = "white", size = 0.5, width = 4, height = 1) +
  
  
  scale_fill_gradientn(
    colors = c("#1a9850", "#ffffbf", "#d73027"), 
    name = "Nº de Saídas",
    breaks = c(0, 25, 50, 75, 100, 125, 150),
    limits = c(0, 150)
  ) +
  
 
  geom_text(aes(label = id_prateleira), size = 3.2, fontface = "bold", color = "black") +
  

  annotate("rect", xmin = 8.5, xmax = 13.5, ymin = -0.2, ymax = 1.2, fill = "grey30", color = "black", alpha = 0.9) +
  annotate("text", x = 11.0, y = 0.5, label = "CARGAS / DESCARGAS", color = "white", fontface = "bold", size = 1.8) +
  

  coord_fixed() +
  xlim(-1, 23) + 
  ylim(-1.5, 16) +
  

  labs(
    title = "Matriz de Identidade",
    x = "Comprimento (Metros)",
    y = "Largura (Metros)"
  ) +
  

  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5, margin = margin(b = 12)),
    axis.title.x = element_text(face = "bold", size = 10, margin = margin(t = 8)),
    axis.title.y = element_text(face = "bold", size = 10, margin = margin(r = 8)),
    legend.title = element_text(face = "bold", size = 9),
    panel.grid.major = element_blank(), # Limpa grelha principal
    panel.grid.minor = element_blank(), # Limpa grelha secundária
    panel.background = element_rect(fill = "white", color = NA) # Fundo totalmente branco
  )


print(mapa_final)
ggsave("diagrama_densidade_armazem.png", plot = mapa_final, width = 11, height = 7, dpi = 300)