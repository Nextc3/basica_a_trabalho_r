#Salvando pressão academica em uma variável
nivel_pressao_academica <- base$nivel_de_pressao_academica

#Analise univariada de pressão acadêmica

# Análise univariada de pressão acadêmica
# Frequência absoluta e relativa de pressão acadêmica
nivel_pressao_academica_freq <- table(nivel_pressao_academica)
nivel_pressao_academica_rel <- prop.table(nivel_pressao_academica_freq)
# Criando um data frame para visualização
nivel_pressao_academica_df <- data.frame(
  Nivel_Pressao_Academica = names(nivel_pressao_academica_freq),
  Frequencia = as.numeric(nivel_pressao_academica_freq),
  Percentual = as.numeric(nivel_pressao_academica_rel) * 100
)
# Visualizando a tabela de pressão acadêmica
nivel_pressao_academica_df
# Usando flextable para formatar a tabela
nivel_pressao_academica_ft <- flextable(nivel_pressao_academica_df) %>%
  set_header_labels(Nivel_Pressao_Academica = "Nível de Pressão Acadêmica",
                    Frequencia = "Quantidade",
                    Percentual = "Percentual (%)") %>%
  theme_vanilla() %>%
  set_table_properties(width = 0.5, layout = "autofit")

# Exibindo a tabela formatada 
nivel_pressao_academica_ft

# Carregar pacotes necessários
library(flextable)
library(dplyr)

# Resumo estatístico
resumo_pressao_academica <- summary(nivel_pressao_academica)

# Transformar em data.frame
resumo_pressao_academica_df <- data.frame(
  Estatistica = names(resumo_pressao_academica),
  Valor = as.numeric(resumo_pressao_academica)
)

# Renomear para nomes mais amigáveis
resumo_pressao_academica_df$Estatistica <- recode(resumo_pressao_academica_df$Estatistica,
                                                  "Min."     = "Mínimo",
                                                  "1st Qu."  = "1º Quartil (25%)",
                                                  "Median"   = "Mediana (50%)",
                                                  "Mean"     = "Média",
                                                  "3rd Qu."  = "3º Quartil (75%)",
                                                  "Max."     = "Máximo"
)

# Criar a flextable com título e fonte
resumo_pressao_academica_ft <- flextable(resumo_pressao_academica_df) %>%
  set_header_labels(Estatistica = "Estatística",
                    Valor = "Valor") %>%
  theme_vanilla() %>%
  set_caption("Tabela 1 – Medidas descritivas da Pressão Acadêmica") %>%
  add_footer_lines(values = c(
    paste("Fonte: Depression Student Dataset (2023)"))
  ) %>%
  set_table_properties(width = 0.5, layout = "autofit")

# Exibir a tabela
resumo_pressao_academica_ft
