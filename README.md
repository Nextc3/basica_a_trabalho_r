# Análise de Depressão em Estudantes Indianos 

Este repositório contém um _workflow_ em **R** que realiza uma análise estatística exploratória sobre dados de depressão e fatores associados em estudantes da Índia.  O estudo utiliza como base o _dataset_ `estudantes_depressao.csv` (derivado do [Depression Student Dataset – Kaggle](https://www.kaggle.com/datasets/ikynahidwin/depression-student-dataset/data)) e gera tabelas formatadas e visualizações gráficas para facilitar a interpretação dos resultados.

---
## Sumário
1. [Descrição do Problema](#descrição-do-problema)
2. [Estrutura do Projeto](#estrutura-do-projeto)
3. [Dataset](#dataset)
4. [Dependências](#dependências)
5. [Passo a Passo para Execução](#passo-a-passo-para-execução)
6. [Descrição das Análises](#descrição-das-análises)
7. [Resultados Esperados](#resultados-esperados)
8. [Autores](#autores)

---
## Descrição do Problema
A saúde mental de estudantes universitários tornou-se um tema de preocupação global. Este projeto busca investigar a prevalência de **depressão** e **pensamentos suicidas** entre estudantes indianos, além de mapear fatores de risco como **pressão acadêmica**, **duração do sono**, **idade** e **gênero**.  
O objetivo principal é identificar correlações que possam subsidiar políticas de prevenção e suporte psicológico.

## Estrutura do Projeto
```
├── Analise_Caio_Costa_Nalanda_Xavier.R   # Script principal de análise
├── estudantes_depressao.csv              # Base de dados utilizada
└── README.md                             # Este documento
```

## Dataset
Arquivo: `estudantes_depressao.csv`  
Abaixo, a lista de variáveis presentes:

| Coluna | Descrição |
| ------ | --------- |
| `genero` | Sexo do estudante (`Homem` / `Mulher`) |
| `idade`  | Idade em anos (numérico) |
| `nivel_de_pressao_academica` | Escala numérica (1–5) que mede quão pressionado o estudante se sente academicamente |
| `duracao_do_sono` | Faixa de horas de sono por noite (`Menos de 5 horas`, `5-6 horas`, `7-8 horas`, `Mais de 8 horas`) |
| `voce_ja_teve_pensamentos_suicidas` | Histórico de pensamentos suicidas (`Sim` / `Não`) |
| `depressao` | Indicação de depressão (`Sim` / `Não`) |

> Fontes de dados:  
> • Base derivada utilizada neste projeto: [Depression Student Dataset – Kaggle](https://www.kaggle.com/datasets/ikynahidwin/depression-student-dataset/data)  
> • Dataset original: [Depression Survey Dataset for Analysis – Kaggle](https://www.kaggle.com/datasets/sumansharmadataworld/depression-surveydataset-for-analysis)  
> Amostra: ~100 observações selecionadas e adaptadas para fins didáticos.

## Dependências
Recomenda-se **R ≥ 4.0**. Instale os pacotes abaixo uma única vez:
```r
install.packages(c(
  "readr",     # leitura de CSV
  "janitor",   # limpeza de nomes de colunas
  "flextable", # formatação de tabelas
  "tidyverse", # dplyr, ggplot2, etc.
  "ggplot2"    # visualizações (já presente no tidyverse)
))
```

## Passo a Passo para Execução
1. Clone ou faça download deste repositório.
2. Abra o arquivo `Analise_Caio_Costa_Nalanda_Xavier.R` no RStudio ou rode via terminal:
   ```bash
   Rscript Analise_Caio_Costa_Nalanda_Xavier.R
   ```
3. O script irá:
   * Carregar/instalar automaticamente os pacotes necessários;
   * Ler `estudantes_depressao.csv`;
   * Gerar tabelas (_flextable_) e gráficos (`ggplot2`) exibidos na *Viewer* do RStudio ou na saída padrão.
4. Caso deseje salvar as figuras, ajuste as funções `ggsave()` nos trechos correspondentes.

## Descrição das Análises
O script está modularizado em seções comentadas:

| Seção | Objetivo |
| ----- | -------- |
| **Preprocessamento** | Instalação/carregamento de pacotes e definição da função utilitária `format_pct()` |
| **Pensamentos Suicidas** | Frequência, percentual e gráfico de pizza (Gráfico 1) |
| **Pressão Acadêmica** | Distribuição de níveis, resumo estatístico e gráfico de barras (Gráfico 2) |
| **Duração do Sono** | Frequência/percentual, tabela e gráfico de barras (Gráfico 3) |
| **Gênero** | Frequência por sexo e gráfico de barras (Gráfico 4) |
| **Idade** | Estatísticas resumidas, histograma e gráfico de densidade (Gráficos 5 e 6) |
| **Análises Bivariadas** | Relações entre: 
  * Gênero × Pensamentos Suicidas (Tabela 7)
  * Pressão Acadêmica × Pensamentos Suicidas (Tabela 8)
  * Duração do Sono × Pensamentos Suicidas (Tabela 9)
  * Duração do Sono × Depressão (Tabela 12)
  * Pensamentos Suicidas × Depressão (Tabela 13)
| **Depressão × Idade** | Gráfico de violino (Gráfico 11) mostrando a distribuição da idade por status de depressão |

Cada tabela utiliza `flextable` para gerar uma apresentação elegante, incluindo *caption*, formatação numérica em PT-BR (vírgula decimal) e fonte de dados.

## Resultados Esperados
Ao executar o script você deverá visualizar:
* **13 tabelas** numeradas e comentadas no script.
* **11 gráficos** (pizza, barras, densidade, violino, etc.).
* _Insights_ como:
  * Maior proporção de pensamentos suicidas entre estudantes com alta pressão acadêmica.
  * Relação entre menor duração de sono e maior taxa de depressão.
  * Distribuição de idade similar entre grupos com e sem depressão.

_Nota:_ os resultados são ilustrativos e não devem ser generalizados.

## Autores
* **Caio Costa Cavalcante**  
* **Nalanda Xavier da Silva**  

## Relatório RMarkdown

Além do script de análise, há também o arquivo `Relatorio_Analise_Depressao_Estudantes.Rmd`, que gera um relatório completo (HTML e PDF) com todas as tabelas, gráficos e conclusões desta pesquisa.

Para renderizar o relatório:

```r
# HTML
rmarkdown::render("Relatorio_Analise_Depressao_Estudantes.Rmd", output_format = "html_document")

# PDF (requer LaTeX)
rmarkdown::render("Relatorio_Analise_Depressao_Estudantes.Rmd", output_format = "pdf_document")
```

## Estrutura Completa do Repositório

```
├── Analise_Caio_Costa_Nalanda_Xavier.R
├── Relatorio_Analise_Depressao_Estudantes.Rmd
├── estudantes_depressao.csv
├── Relatório científico - Nalanda Xavier da Silva e Caio Costa Cavalcante.pdf
└── README.md
```

Sinta-se à vontade para abrir *issues* ou propor melhorias!
