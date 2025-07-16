# ==== Início: preprocessamento.R ====
# instalando os pacotes
install.packages("readr")
install.packages("janitor")
install.packages("flextable")
install.packages("tidyverse")

# carregando os pacotes
library(dplyr) 
library(janitor)
library(flextable)  
library(tidyverse)
library(ggplot2) 
# ==== Fim do Preprocessamento ====

# Função utilitária para formatar percentuais com duas casas decimais e vírgula
format_pct <- function(x) {
  format(round(x, 2), nsmall = 2, decimal.mark = ",")
}


#carregando os dados
base <- read_csv("estudantes_depressao.csv")


#visualizando os dados
head(base)


#Pensamento Suicidas

# Salvando a variável com os dados
pensamentos_suicidas <- base$voce_ja_teve_pensamentos_suicidas

# Frequência absoluta e relativa
pensamentos_suicidas_freq <- table(pensamentos_suicidas)
pensamentos_suicidas_rel <- prop.table(pensamentos_suicidas_freq)

# Criando dataframe
pensamentos_suicidas_df <- data.frame(
  Pensamentos_Suicidas = names(pensamentos_suicidas_freq),
  Frequencia = as.numeric(pensamentos_suicidas_freq),
  Percentual = as.numeric(pensamentos_suicidas_rel)*100
) %>%
  mutate(Percentual = format_pct(Percentual))

# Tabela flextable
pensamentos_suicidas_ft <- flextable(pensamentos_suicidas_df) %>%
  set_caption("Tabela 1 – Percentual de Pensamentos Suicidas Estudantes na Índia") %>%
  set_header_labels(Pensamentos_Suicidas="Pensamentos Suicidas", Frequencia="Quantidade", Percentual="Percentual (%)") %>%
  theme_vanilla() %>%
  set_table_properties(width=0.5, layout="autofit") %>%
  add_footer_lines(c("Fonte: Depression Student Dataset (Primeiro semestre de 2023)", paste("Data da análise:", format(Sys.Date(), "%d/%m/%Y"))))

# Exibir tabela
print(pensamentos_suicidas_ft)

# Tabela 1 feita no código acima

# Gráfico de pizza

pensamentos_suicidas_df <- pensamentos_suicidas_df %>% mutate(PercentualNum = as.numeric(gsub(",",".",Percentual)))

ggplot(pensamentos_suicidas_df, aes(x="", y=PercentualNum, fill=Pensamentos_Suicidas)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y") +
  geom_label(aes(label=paste0(Pensamentos_Suicidas,"\n",Percentual,"%")), position=position_stack(vjust=0.5), size=4) +
  labs(title="Gráfico 1 – Distribuição Percentual de Pensamentos Suicidas na Índia", fill="Pensamentos Suicidas", caption=paste("Fonte: Depression Student Dataset (2023)\nData da análise:", format(Sys.Date(), "%d/%m/%Y"))) +
  theme_void() +
  theme(legend.position="right", plot.caption=element_text(hjust=0.5, face="italic", size=8))
# ==== Fim de Pensamento suicida ====

# Pressão Acadêmica

# Salvando pressão academica em uma variável
nivel_pressao_academica <- base$nivel_de_pressao_academica

# Frequência absoluta e relativa
nivel_pressao_academica_freq <- table(nivel_pressao_academica)
nivel_pressao_academica_rel <- prop.table(nivel_pressao_academica_freq)

nivel_pressao_academica_df <- data.frame(
  Nivel_Pressao_Academica = names(nivel_pressao_academica_freq),
  Frequencia = as.numeric(nivel_pressao_academica_freq),
  Percentual = as.numeric(nivel_pressao_academica_rel)*100
) %>%
  mutate(Percentual = format(round(Percentual,2), nsmall = 2, decimal.mark=","))

nivel_pressao_academica_ft <- flextable(nivel_pressao_academica_df) %>%
  set_caption("Tabela 2 – Frequência e Percentual de Nível de Pressão Acadêmica") %>%
  set_header_labels(Nivel_Pressao_Academica="Nível de Pressão Acadêmica", Frequencia="Quantidade", Percentual="Percentual (%)") %>%
  theme_vanilla() %>%
  set_table_properties(width=0.5, layout="autofit") %>%
  add_footer_lines(c("Fonte: Depression Student Dataset (2023)", paste("Data da análise:", format(Sys.Date(), "%d/%m/%Y"))))

print(nivel_pressao_academica_ft)

# Resumo estatístico
# Resumo estatístico da variável
resumo_pressao_academica <- summary(nivel_pressao_academica)

# Transformar em data.frame
resumo_pressao_academica_df <- data.frame(
  Estatistica = names(resumo_pressao_academica),
  Valor = as.numeric(resumo_pressao_academica)
)

# Renomear para nomes mais amigáveis
resumo_pressao_academica_df$Estatistica <- recode(resumo_pressao_academica_df$Estatistica,
                                                  "Min."     = "Pressão Mínima",  
                                                  "1st Qu."  = "2 ou menor",
                                                  "Median"   = "Pressão Moderada",
                                                  "Mean"     = "Média",
                                                  "3rd Qu."  = "4 ou mais (Alto)",
                                                  "Max."     = "Muita Pressão")

# Criar a flextable com título e fonte corrigindo o erro de format()
resumo_pressao_academica_ft <- flextable(resumo_pressao_academica_df) %>%
  set_header_labels(Estatistica = "Estatística", Valor = "Valor") %>%
  theme_vanilla() %>%
  set_caption("Tabela 3 – Níveis de Pressão Acadêmica na Índia") %>%
  add_footer_lines(values = c(
    "Fonte: Depression Student Dataset (2023)",
    paste("Data da análise:", format(Sys.Date(), "%d/%m/%Y"))
  )) %>%
  set_table_properties(width = 0.5, layout = "autofit")

# Exibir a tabela
resumo_pressao_academica_ft


# Gráfico de barras
ggplot(nivel_pressao_academica_df, aes(x = Nivel_Pressao_Academica, y = Percentual, fill = Nivel_Pressao_Academica)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = paste0(Percentual, "%")), vjust = -0.5, size = 4) +
  labs(
    title = "Gráfico 2 – Nível de Pressão Acadêmica na Índia",
    x = "Nível de Pressão Acadêmica",
    y = "Percentual (%)",
    fill = "Nível de Pressão Acadêmica",
    caption = paste("Fonte: Depression Student Dataset (2023)\nData da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    plot.title = element_text(hjust = 0.5)
  )

# ==== Fim de Pressão academica ====

# Duração do Sono

# Salvando duração de sono em uma variável
duracao_sono <- base$duracao_do_sono

# Frequência absoluta e relativa
duracao_sono_freq <- table(duracao_sono)
duracao_sono_rel <- prop.table(duracao_sono_freq)

duracao_sono_df <- data.frame(
  Duracao_Sono = names(duracao_sono_freq),
  Frequencia = as.numeric(duracao_sono_freq),
  Percentual = as.numeric(duracao_sono_rel)*100
) %>%
  mutate(Percentual = format(round(Percentual,2), nsmall = 2, decimal.mark=","))

duracao_sono_ft <- flextable(duracao_sono_df) %>%
  set_caption("Tabela 4 – Frequência e Percentual de Duração do Sono") %>%
  set_header_labels(Duracao_Sono="Duração do Sono", Frequencia="Quantidade", Percentual="Percentual (%)") %>%
  theme_vanilla() %>%
  set_table_properties(width=0.5, layout="autofit") %>%
  add_footer_lines(c("Fonte: Depression Student Dataset (2023)", paste("Data da análise:", format(Sys.Date(), "%d/%m/%Y"))))

print(duracao_sono_ft)

# Gráfico de barras
ggplot(duracao_sono_df, aes(x = Duracao_Sono, y = Percentual, fill = Duracao_Sono)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = paste0(Percentual, "%")), vjust = -0.5, size = 4) +
  labs(
    title = "Gráfico 3 – Duração do Sono na Índia",
    x = "Duração do Sono",
    y = "Percentual (%)",
    fill = "Duração do Sono",
    caption = paste("Fonte: Depression Student Dataset (2023)\nData da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    plot.title = element_text(hjust = 0.5)
  )
# ==== Fim de Duração Sono ====

# Gênero
# Salvando gênero em uma variável
genero <- base$genero
# Frequência absoluta e relativa

genero_freq <- table(genero)
genero_rel <- prop.table(genero_freq)

# Criando dataframe com duas casas decimais e vírgula no percentual
genero_df <- data.frame(
  Genero = names(genero_freq),
  Frequencia = as.numeric(genero_freq),
  Percentual = as.numeric(genero_rel)*100
) %>%
  mutate(Percentual = format(round(Percentual,2), nsmall = 2, decimal.mark=","))

# Tabela flextable
genero_ft <- flextable(genero_df) %>%
  set_caption("Tabela 5 – Frequência e Percentual de Gênero") %>%
  set_header_labels(Genero="Gênero", Frequencia="Quantidade", Percentual="Percentual (%)") %>%
  theme_vanilla() %>%
  set_table_properties(width=0.5, layout="autofit") %>%
  add_footer_lines(c("Fonte: Depression Student Dataset (2023)", paste("Data da análise:", format(Sys.Date(), "%d/%m/%Y"))))

# Exibir tabela
print(genero_ft)
# Gráfico de barras
ggplot(genero_df, aes(x = Genero, y = Percentual, fill = Genero)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = paste0(Percentual, "%")), vjust = -0.5, size = 4) +
  labs(
    title = "Gráfico 4 – Distribuição de Gênero dos Estudantes da Índia",
    x = "Gênero",
    y = "Percentual (%)",
    fill = "Gênero",
    caption = paste("Fonte: Depression Student Dataset (2023)\nData da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    plot.title = element_text(hjust = 0.5)
  )

# ==== Fim de Gênero ====

# Idade
# Salvando idade em uma variável
idade <- base$idade

# Análise estatística com valores arredondados e nomes acessíveis
idade_stats <- data.frame(
  Estatistica = c("Idade Média", "Mediana da Idade", "Variação da Idade", "Idade Mínima", "Idade Máxima"),
  Valor = c(
    mean(idade, na.rm = TRUE),
    median(idade, na.rm = TRUE),
    sd(idade, na.rm = TRUE),
    min(idade, na.rm = TRUE),
    max(idade, na.rm = TRUE)
  )
) %>%
  mutate(Valor = format(round(Valor, 2), nsmall = 2, decimal.mark = ","))  # Duas casas decimais, vírgula como separador

# Criando a flextable
idade_stats_ft <- flextable(idade_stats) %>%
  set_caption("Tabela 6 – Estatísticas Descritivas da Idade dos Estudantes") %>%
  set_header_labels(Estatistica = "Estatística", Valor = "Valor (anos)") %>%
  theme_vanilla() %>%
  set_table_properties(width = 0.5, layout = "autofit") %>%
  add_footer_lines(c(
    "Fonte: Depression Student Dataset (2023)", 
    paste("Data da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ))

# Exibir tabela
print(idade_stats_ft)

# Histograma de idade
ggplot(base, aes(x = idade)) +
  geom_histogram(binwidth = 1, fill = "#69b3a2", color = "black", alpha = 0.7) +
  labs(
    title = "Gráfico 5 – Histograma da Idade dos Estudantes da Índia",
    x = "Idade (anos)",
    y = "Frequência",
    caption = paste("Fonte: Depression Student Dataset (2023)\nData da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# Gráfico de densidade de idade
ggplot(base, aes(x = idade)) +
  geom_density(fill = "#69b3a2", alpha = 0.7) +
  labs(
    title = "Gráfico 6 – Densidade da Idade dos Estudantes da Índia",
    x = "Idade (anos)",
    y = "Densidade",
    caption = paste("Fonte: Depression Student Dataset (2023)\nData da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# Gráfico violino
ggplot(base, aes(x = "", y = idade)) +
  geom_violin(fill = "#69b3a2", alpha = 0.7) +
  labs(
    title = "Gráfico 7 – Gráfico Violino da Idade dos Estudantes da Índia",
    x = "",
    y = "Idade (anos)",
    caption = paste("Fonte: Depression Student Dataset (2023)\nData da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ) +
  theme_minimal() +
  theme(axis.title.x = element_blank(), plot.title = element_text(hjust = 0.5))
# ==== Fim de Idade ====




# Análise de Gênero e Pensamentos Suicidas
# Criando tabela cruzada
tabela_cruzada <- table(base$genero, base$voce_ja_teve_pensamentos_suicidas)
# Convertendo para data.frame e calculando percentuais
tabela_cruzada_df <- as.data.frame(tabela_cruzada) %>%
  mutate(Percentual = format_pct(Freq / sum(Freq) * 100))
# Renomeando colunas
colnames(tabela_cruzada_df) <- c("Gênero", "Pensamentos_Suicidas", "Frequencia", "Percentual")
# Criando flextable
tabela_cruzada_ft <- flextable(tabela_cruzada_df) %>%
  set_caption("Tabela 7 – Relação entre Gênero e Pensamentos Suicidas") %>%
  set_header_labels(Gênero = "Gênero", Pensamentos_Suicidas = "Pensamentos Suicidas", Frequencia = "Frequência", Percentual = "Percentual (%)") %>%
  theme_vanilla() %>%
  set_table_properties(width = 0.5, layout = "autofit") %>%
  add_footer_lines(c(
    "Fonte: Depression Student Dataset (2023)",
    paste("Data da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ))
# Exibir tabela cruzada
print(tabela_cruzada_ft)
# Gráfico de barras agrupadas
ggplot(tabela_cruzada_df, aes(x = Gênero, y = Frequencia, fill = Pensamentos_Suicidas)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Gráfico 8 – Relação entre Gênero e Pensamentos Suicidas",
    x = "Gênero",
    y = "Frequência",
    fill = "Pensamentos Suicidas",
    caption = paste("Fonte: Depression Student Dataset (2023)\nData da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ) +
  scale_fill_manual(values = c("Sim" = "#59A14F", "Não" = "#E15759")) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))
# ==== Fim de Análise de Gênero e Pensamentos Suicidas ====


# Análise de Pressão Acadêmica e Pensamentos Suicidas
# Tabela cruzada
tabela_pressao_suicidas <- table(base$nivel_de_pressao_academica, base$voce_ja_teve_pensamentos_suicidas)

# Converter para data.frame com proporção por linha
tabela_pressao_suicidas_df <- prop.table(tabela_pressao_suicidas, 1) * 100
tabela_completa <- as.data.frame.matrix(tabela_pressao_suicidas_df)

# Adicionar frequência absoluta para contexto
frequencias_absolutas <- as.data.frame.matrix(tabela_pressao_suicidas)

# Juntar ambos: percentual + frequência
tabela_final <- tibble::rownames_to_column(tabela_completa, "Pressão Acadêmica") %>%
  left_join(tibble::rownames_to_column(frequencias_absolutas, "Pressão Acadêmica"), by = "Pressão Acadêmica") %>%
  rename(
    `Sim (%)` = Sim.x,
    `Não (%)` = Não.x,
    `Sim (n)` = Sim.y,
    `Não (n)` = Não.y
  ) %>%
  mutate(
    `Sim (%)` = format(round(`Sim (%)`, 2), nsmall = 2, decimal.mark = ","),
    `Não (%)` = format(round(`Não (%)`, 2), nsmall = 2, decimal.mark = ",")
  )

# Criar flextable
tabela_pressao_suicidas_ft <- flextable(tabela_final) %>%
  set_caption("Tabela 8 – Relação entre Nível de Pressão Acadêmica e Pensamentos Suicidas") %>%
  set_header_labels(
    `Pressão Acadêmica` = "Nível de Pressão Acadêmica",
    `Sim (%)` = "Sim (%)",
    `Não (%)` = "Não (%)",
    `Sim (n)` = "Sim (n)",
    `Não (n)` = "Não (n)"
  ) %>%
  theme_vanilla() %>%
  set_table_properties(width = 1.0, layout = "autofit") %>%
  add_footer_lines(c(
    "Fonte: Depression Student Dataset (2023)",
    paste("Data da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ))

# Exibir tabela
print(tabela_pressao_suicidas_ft)

# Gráfico de barras agrupadas
ggplot(tabela_final, aes(x = `Pressão Acadêmica`, y = `Sim (n)`, fill = "Sim")) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_bar(aes(y = `Não (n)`, fill = "Não"), stat = "identity", position = "dodge") +
  labs(
    title = "Gráfico 9 – Relação entre Nível de Pressão Acadêmica e Pensamentos Suicidas",
    x = "Nível de Pressão Acadêmica",
    y = "Frequência Absoluta",
    fill = "Pensamentos Suicidas",
    caption = paste("Fonte: Depression Student Dataset (2023)\nData da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ) +
  scale_fill_manual(values = c("Sim" = "#59A14F", "Não" = "#E15759")) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# ==== Fim de Análise de Pressão Acadêmica e Pensamentos Suicidas ====

# Análise de Duração do Sono e Pensamentos Suicidas
# Tabela cruzada
tabela_sono_suicidas <- table(base$duracao_do_sono, base$voce_ja_teve_pensamentos_suicidas)
# Converter para data.frame com proporção por linha
tabela_sono_suicidas_df <- prop.table(tabela_sono_suicidas, 1) * 100
tabela_completa_sono <- as.data.frame.matrix(tabela_sono_suicidas_df)
# Adicionar frequência absoluta para contexto
frequencias_absolutas_sono <- as.data.frame.matrix(tabela_sono_suicidas)
# Juntar ambos: percentual + frequência
tabela_final_sono <- tibble::rownames_to_column(tabela_completa_sono, "Duração do Sono") %>%
  left_join(tibble::rownames_to_column(frequencias_absolutas_sono, "Duração do Sono"), by = "Duração do Sono") %>%
  rename(
    `Sim (%)` = Sim.x,
    `Não (%)` = Não.x,
    `Sim (n)` = Sim.y,
    `Não (n)` = Não.y
  ) %>%
  mutate(
    `Sim (%)` = format(round(`Sim (%)`, 2), nsmall = 2, decimal.mark = ","),
    `Não (%)` = format(round(`Não (%)`, 2), nsmall = 2, decimal.mark = ",")
  )
# Criar flextable
tabela_sono_suicidas_ft <- flextable(tabela_final_sono) %>%
  set_caption("Tabela 9 – Relação entre Duração do Sono e Pensamentos Suicidas") %>%
  set_header_labels(
    `Duração do Sono` = "Duração do Sono",
    `Sim (%)` = "Sim (%)",
    `Não (%)` = "Não (%)",
    `Sim (n)` = "Sim (n)",
    `Não (n)` = "Não (n)"
  ) %>%
  theme_vanilla() %>%
  set_table_properties(width = 1.0, layout = "autofit") %>%
  add_footer_lines(c(
    "Fonte: Depression Student Dataset (2023)",
    paste("Data da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ))
# Exibir tabela
print(tabela_sono_suicidas_ft)

# Fim de Análise de Duração do Sono e Pensamentos Suicidas

# Análise de Depressão
# Salvando a variável de depressão em uma variável
depressao <- base$depressao
# Frequência absoluta e relativa
depressao_freq <- table(depressao)
depressao_rel <- prop.table(depressao_freq)
# Criando dataframe com duas casas decimais e vírgula no percentual
depressao_df <- data.frame(
  Depressao = names(depressao_freq),
  Frequencia = as.numeric(depressao_freq),
  Percentual = as.numeric(depressao_rel) * 100
) %>%
  mutate(Percentual = format(round(Percentual, 2), nsmall = 2, decimal.mark = ","))
# Tabela flextable
depressao_ft <- flextable(depressao_df) %>%
  set_caption("Tabela 10 – Frequência e Percentual de Depressão") %>%
  set_header_labels(Depressao = "Depressão", Frequencia = "Quantidade", Percentual = "Percentual (%)") %>%
  theme_vanilla() %>%
  set_table_properties(width = 0.5, layout = "autofit") %>%
  add_footer_lines(c("Fonte: Depression Student Dataset (2023)", paste("Data da análise:", format(Sys.Date(), "%d/%m/%Y"))))
# Exibir tabela
print(depressao_ft)

# Fim de Análise de Depressão

# Análise de Pressão Acadêmica e Depressão
# Tabela cruzada
tabela_pressao_depressao <- table(base$nivel_de_pressao_academica, base$depressao)
# Converter para data.frame com proporção por linha
tabela_pressao_depressao_df <- prop.table(tabela_pressao_depressao, 1) * 100
tabela_completa_pressao <- as.data.frame.matrix(tabela_pressao_depressao_df)
# Adicionar frequência absoluta para contexto
frequencias_absolutas_pressao <- as.data.frame.matrix(tabela_pressao_depressao)
# Juntar ambos: percentual + frequência
tabela_final_pressao <- tibble::rownames_to_column(tabela_completa_pressao, "Nível de Pressão Acadêmica") %>%
  left_join(tibble::rownames_to_column(frequencias_absolutas_pressao, "Nível de Pressão Acadêmica"), by = "Nível de Pressão Acadêmica") %>%
  rename(
    `Sim (%)` = Sim.x,
    `Não (%)` = Não.x,
    `Sim (n)` = Sim.y,
    `Não (n)` = Não.y
  ) %>%
  mutate(
    `Sim (%)` = format(round(`Sim (%)`, 2), nsmall = 2, decimal.mark = ","),
    `Não (%)` = format(round(`Não (%)`, 2), nsmall = 2, decimal.mark = ",")
  )
# Criar flextable
tabela_pressao_depressao_ft <- flextable(tabela_final_pressao) %>%
  set_caption("Tabela 11 – Relação entre Nível de Pressão Acadêmica e Depressão") %>%
  set_header_labels(
    `Nível de Pressão Acadêmica` = "Nível de Pressão Acadêmica",
    `Sim (%)` = "Sim (%)",
    `Não (%)` = "Não (%)",
    `Sim (n)` = "Sim (n)",
    `Não (n)` = "Não (n)"
  ) %>%
  theme_vanilla() %>%
  set_table_properties(width = 1.0, layout = "autofit") %>%
  add_footer_lines(c(
    "Fonte: Depression Student Dataset (2023)",
    paste("Data da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ))
# Exibir tabela
print(tabela_pressao_depressao_ft)

# Gráfico de barras agrupadas
ggplot(tabela_final_pressao, aes(x = `Nível de Pressão Acadêmica`, y = `Sim (n)`, fill = "Sim")) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_bar(aes(y = `Não (n)`, fill = "Não"), stat = "identity", position = "dodge") +
  labs(
    title = "Gráfico 10 – Relação entre Nível de Pressão Acadêmica e Depressão",
    x = "Nível de Pressão Acadêmica",
    y = "Frequência Absoluta",
    fill = "Depressão",
    caption = paste("Fonte: Depression Student Dataset (2023)\nData da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ) +
  scale_fill_manual(values = c("Sim" = "#59A14F", "Não" = "#E15759")) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))
# ==== Fim de Análise de Pressão Acadêmica e Depressão ====

# Análise de Duração do Sono e Depressão
# Tabela cruzada
tabela_sono_depressao <- table(base$duracao_do_sono, base$depressao)
# Converter para data.frame com proporção por linha
tabela_sono_depressao_df <- prop.table(tabela_sono_depressao, 1) * 100
tabela_completa_sono_depressao <- as.data.frame.matrix(tabela_sono_depressao_df)
# Adicionar frequência absoluta para contexto
frequencias_absolutas_sono_depressao <- as.data.frame.matrix(tabela_sono_depressao)
# Juntar ambos: percentual + frequência
tabela_final_sono_depressao <- tibble::rownames_to_column(tabela_completa_sono_depressao, "Duração do Sono") %>%
  left_join(tibble::rownames_to_column(frequencias_absolutas_sono_depressao, "Duração do Sono"), by = "Duração do Sono") %>%
  rename(
    `Sim (%)` = Sim.x,
    `Não (%)` = Não.x,
    `Sim (n)` = Sim.y,
    `Não (n)` = Não.y
  ) %>%
  mutate(
    `Sim (%)` = format(round(`Sim (%)`, 2), nsmall = 2, decimal.mark = ","),
    `Não (%)` = format(round(`Não (%)`, 2), nsmall = 2, decimal.mark = ",")
  )
# Criar flextable
tabela_sono_depressao_ft <- flextable(tabela_final_sono_depressao) %>%
  set_caption("Tabela 12 – Relação entre Duração do Sono e Depressão") %>%
  set_header_labels(
    `Duração do Sono` = "Duração do Sono",
    `Sim (%)` = "Sim (%)",
    `Não (%)` = "Não (%)",
    `Sim (n)` = "Sim (n)",
    `Não (n)` = "Não (n)"
  ) %>%
  theme_vanilla() %>%
  set_table_properties(width = 1.0, layout = "autofit") %>%
  add_footer_lines(c(
    "Fonte: Depression Student Dataset (2023)",
    paste("Data da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ))
# Exibir tabela
print(tabela_sono_depressao_ft)



# ==== Fim de Análise de Duração do Sono e Depressão ====

# Análise de Pensamentos Suicidas e Depressão
# Tabela cruzada
tabela_suicidas_depressao <- table(base$voce_ja_teve_pensamentos_suicidas, base$depressao)
# Converter para data.frame com proporção por linha
tabela_suicidas_depressao_df <- prop.table(tabela_suicidas_depressao, 1) * 100
tabela_completa_suicidas <- as.data.frame.matrix(tabela_suicidas_depressao_df)
# Adicionar frequência absoluta para contexto
frequencias_absolutas_suicidas <- as.data.frame.matrix(tabela_suicidas_depressao)
# Juntar ambos: percentual + frequência
tabela_final_suicidas <- tibble::rownames_to_column(tabela_completa_suicidas, "Pensamentos Suicidas") %>%
  left_join(tibble::rownames_to_column(frequencias_absolutas_suicidas, "Pensamentos Suicidas"), by = "Pensamentos Suicidas") %>%
  rename(
    `Sim (%)` = Sim.x,
    `Não (%)` = Não.x,
    `Sim (n)` = Sim.y,
    `Não (n)` = Não.y
  ) %>%
  mutate(
    `Sim (%)` = format(round(`Sim (%)`, 2), nsmall = 2, decimal.mark = ","),
    `Não (%)` = format(round(`Não (%)`, 2), nsmall = 2, decimal.mark = ",")
  )
# Criar flextable
tabela_suicidas_depressao_ft <- flextable(tabela_final_suicidas) %>%
  set_caption("Tabela 13 – Relação entre Pensamentos Suicidas e Depressão") %>%
  set_header_labels(
    `Pensamentos Suicidas` = "Pensamentos Suicidas",
    `Sim (%)` = "Sim (%)",
    `Não (%)` = "Não (%)",
    `Sim (n)` = "Sim (n)",
    `Não (n)` = "Não (n)"
  ) %>%
  theme_vanilla() %>%
  set_table_properties(width = 1.0, layout = "autofit") %>%
  add_footer_lines(c(
    "Fonte: Depression Student Dataset (2023)",
    paste("Data da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ))
# Exibir tabela
print(tabela_suicidas_depressao_ft)


# ==== Fim de Análise de Pensamentos Suicidas e Depressão ====

# Análise bivariada de Depressão e idade com violino
ggplot(base, aes(x = depressao, y = idade, fill = depressao)) +
  geom_violin(trim = FALSE, alpha = 0.7) +
  geom_boxplot(width = 0.1, color = "black", outlier.shape = NA) +
  labs(
    title = "Gráfico 11 – Distribuição da Idade por Nível de Depressão",
    x = "Depressão",
    y = "Idade (anos)",
    fill = "Depressão",
    caption = paste("Fonte: Depression Student Dataset (2023)\nData da análise:", format(Sys.Date(), "%d/%m/%Y"))
  ) +
  scale_fill_manual(values = c("Sim" = "#59A14F", "Não" = "#E15759")) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))








