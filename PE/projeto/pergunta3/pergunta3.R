# Carregar as bibliotecas necessárias
library(readxl)
library(ggplot2)
library(dplyr)
if (!require("lubridate")) install.packages("lubridate")
library(lubridate)
dados <- read_excel("electricity.xlsx")

# Converter colunas relevantes para os tipos apropriados
dados$YEAR <- as.numeric(dados$YEAR)
dados$MONTH <- as.numeric(dados$MONTH)
dados$VALUE <- as.numeric(gsub(",", "", dados$VALUE))

# Selecionar os dados a partir de janeiro de 2015
dados <- dados[dados$YEAR >= 2015, ]

# Filtrar os dados para incluir apenas IEA Total, Hungary e Iceland
dados <- dados[dados$COUNTRY %in% c("IEA Total", "Hungary", "Iceland"), ]
#filtrar os dados por renewables
dados <- dados[dados$PRODUCT %in% c("Renewables"),]
# Agregar dados por ano, mês e país
dados$Date <- ymd(paste(dados$YEAR, dados$MONTH, "01", sep= "-"))

#multiplica os dados da coluna share por 100
dados$share <- as.numeric(dados$share) * 100

# Criar o gráfico
grafico <- ggplot(dados, aes(x = Date, y = share, group = COUNTRY, color = COUNTRY)) +
  geom_line() +
  geom_point(size = 3, shape = 21, fill = "white") +
  scale_y_continuous(labels = scales::percent_format(scale = 1), limits = c(0, 100)) +
  labs(title = "Monthly Proportion of Electricity Produced from Renewable Sources",
       x = "Month",
       y = "Renewables Percentage",
       color = "Country") +
  theme_minimal()

# Salvar o gráfico em um arquivo PDF
ggsave("electricity_renewables.pdf", plot = grafico, width = 8.27, height = 11.69)  # A4 size in inches
