# Carregar a biblioteca necessária
library(ggplot2)

# Leitura dos dados do arquivo CSV
dados <- read.csv("master.csv")

# Selecionar os dados referentes ao ano de 2002 e ao grupo etário 55-74 anos
dados_selecionados <- subset(dados, year == 2002 & age == "55-74 years")


# Criar o gráfico de extremos e quartis do número de suicídios por 100.000 habitantes por país, comparando homens e mulheres
grafico <- ggplot(dados_selecionados, aes(x = sex, y = suicides.100k.pop, fill = sex)) +
  geom_boxplot()
  labs(title = "Comparison of Suicide Rates between Genders (2002, Age 55-74 years)",
       x = "Sex",
       y = "Suicides per 100k Population") +
  scale_fill_manual(values = c("blue", "pink")) +  # Definir cores para homens e mulheres
  theme_minimal()

# Salvar o gráfico em um arquivo PDF
ggsave("suicide_comparison.pdf", plot = grafico, width = 8.27, height = 11.69)  # A4 size in inches
