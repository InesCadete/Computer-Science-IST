# dados_paises <- read.csv("Paises_PIB_ICH.csv")
# paises_selecionados <- subset(dados_paises, Continent %in% c("Europe", "Americas"))
# install.packages("ggplot2")
# library(ggplot2)
# ggplot(paises_selecionados, aes(x = log(GDP), y = HCI, label = Country)) +
#   geom_point() +
#   geom_text(hjust = 0, vjust = 0) +
#   xlab("Log GDP per capita") +
#   ylab("Human Capital Index") +
#   theme_minimal()
# 
# 
# pdf("grafico_paises.pdf", width = 8.27, height = 11.69)
# print(grafico)  # Substitua 'grafico' pelo nome do objeto do gráfico
# dev.off()
# 
# # 
# install.packages("readxl") 
# install.packages("ggplot2")
# Carregar as bibliotecas necessárias
library(readxl)
library(ggplot2)

# Leitura dos dados do ficheiro CSV
dados <- read.csv("Paises_PIB_ICH.csv")

# Seleção dos países dos continentes Europe e Americas
dados_selecionados <- subset(dados, Continent %in% c("Europe", "Americas"))

# Lista de países a serem destacados
paises_destacados <- c("Lithuania", "Iceland", "United States", "Saint Lucia")

# Criação do gráfico de dispersão
grafico <- ggplot(dados_selecionados, aes(x = GDP, y = HCI, color = Continent)) +
  geom_point() +
  scale_x_log10() +
  geom_point(data = subset(dados_selecionados, Country %in% paises_destacados), 
             aes(x = GDP, y = HCI), shape = 21, size = 3, fill = "red") +
  geom_text(data = subset(dados_selecionados, Country %in% paises_destacados), 
            aes(label = Country), vjust = -1, hjust = 0.5) +
  scale_color_manual(values = c("Europe" = "blue", "Americas" = "green")) +
  theme_minimal() +
  labs(title = "Human Capital Index vs GDP per capita",
       x = "GDP per capita (log scale)",
       y = "Human Capital Index",
       color = "Continent")

# Salvar o gráfico em um arquivo PDF
ggsave("grafico_paises.pdf", plot = grafico, width = 8.27, height = 11.69)  # A4 size in inches
