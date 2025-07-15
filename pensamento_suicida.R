#Salvando você já teve pensamentos suicidas em uma variável
pensamentos_suicidas <- base$voce_ja_teve_pensamentos_suicidas

# Análise univariada de pensamentos suicidas

# Frequência absoluta e relativa de pensamentos suicidas
pensamentos_suicidas_freq <- table(pensamentos_suicidas)
pensamentos_suicidas_rel <- prop.table(pensamentos_suicidas_freq)
# Criando um data frame para visualização
pensamentos_suicidas_df <- data.frame(
  Pensamentos_Suicidas = names(pensamentos_suicidas_freq),
  Frequencia = as.numeric(pensamentos_suicidas_freq),
  Percentual = as.numeric(pensamentos_suicidas_rel) * 100
)
# Visualizando a tabela de pensamentos suicidas
pensamentos_suicidas_df

#usando flextable para formatar a tabela
library(flextable)
pensamentos_suicidas_ft <- flextable(pensamentos_suicidas_df) %>%
  set_header_labels(Pensamentos_Suicidas = "Pensamentos Suicidas",
                    Frequencia = "Quantidade",
                    Percentual = "Percentual (%)") %>%
  theme_vanilla() %>%
  set_table_properties(width = 0.5, layout = "autofit")


# Exibindo a tabela formatada 
pensamentos_suicidas_ft

#Gráfico de pizza para pensamentos suicidas
library(ggplot2)
ggplot(pensamentos_suicidas_df, aes(x = "", y = Percentual, fill = Pensamentos_Suicidas)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  labs(
    title = "Pensamentos Suicidas em Adultos Indianos no 1º semestre de 2023",
    fill = "Pensamentos Suicidas",
    caption = "Fonte: Depression Student Dataset (2023)"
  ) +
  theme_void() +
  theme(
    legend.position = "right",
    plot.caption = element_text(hjust = 0.5, face = "italic", size = 8)
  )
