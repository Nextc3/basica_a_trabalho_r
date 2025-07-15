#Salvando duração de sono    em uma variável
duracao_sono <- base$duracao_do_sono

#Analise univariada de duração do sono

# Análise univariada de duração do sono
# Frequência absoluta e relativa de duração do sono
duracao_sono_freq <- table(duracao_sono)
duracao_sono_rel <- prop.table(duracao_sono_freq)
# Criando um data frame para visualização
duracao_sono_df <- data.frame(
  Duracao_Sono = names(duracao_sono_freq),
  Frequencia = as.numeric(duracao_sono_freq),
  Percentual = as.numeric(duracao_sono_rel) * 100
)
# Visualizando a tabela de duração do sono
duracao_sono_df
# Usando flextable para formatar a tabela
duracao_sono_ft <- flextable(duracao_sono_df) %>%
  set_header_labels(Duracao_Sono = "Duração do Sono",
                    Frequencia = "Quantidade",
                    Percentual = "Percentual (%)") %>%
  theme_vanilla() %>%
  set_table_properties(width = 0.5, layout = "autofit")
# Exibindo a tabela formatada
duracao_sono_ft