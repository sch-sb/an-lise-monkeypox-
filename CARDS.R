rm(list=ls())
library(readxl)
library(tidyverse)
library(lubridate)
library(readxl)
library(xlsx)
library(openxlsx)

##Dados

df_monkey <- read_excel("Casos de Monkeypox.xlsx")


##Quantidade de casos


suspeitos <- df_monkey %>%
  filter(STATUS == "Em Investigação"| STATUS == "Indeterminado")

descartados <- df_monkey %>%
  dplyr::filter(df_monkey$STATUS == "Descartado")

confirmados <- df_monkey %>%
  dplyr::filter(df_monkey$STATUS == "Confirmado" | df_monkey$STATUS == "Provável")


##Quantidade de casos por faixa etÃ¡ria

  casos_faixa_etaria <- confirmados %>%
    group_by(`FAIXA ETÁRIA`) %>%
    summarise(count= n())

##Quantidade de casos por sexo
casos_sexo <- confirmados %>%
  dplyr::group_by(SEXO) %>%
  summarise(count = n())


 
##Quantidade de casos segundo RA
casos_RA <- confirmados %>%
  dplyr::group_by(`RA RESIDENCIA`) %>%
  summarise(count= n())


##Quantidade de casos suspeitos e confirmados por data de inÃ­cio de sintomas

c_s<-rbind(confirmados,suspeitos)

casos_data_inicio <- c_s %>%
  mutate(`INICIO DE SINTOMAS`=str_sub(`INICIO DE SINTOMAS`,1,10),
         `INICIO DE SINTOMAS`=as.Date(`INICIO DE SINTOMAS`)) %>%
  dplyr::group_by(`INICIO DE SINTOMAS`) %>%
  summarise(count = n()) %>%
  ungroup()

 
##Planilha de dados:
Colunas <- c("Casos Suspeitos", "Casos Descartados", "Casos Confirmados")
Quantidade <- c(nrow(suspeitos), nrow(descartados), nrow(confirmados))
monkey_cards_casos <- data.frame(Colunas, Quantidade)

names(casos_faixa_etaria)<-c("Faixa Etaria", "Casos")


names(casos_sexo)<-c("Sexo", "Casos")


names(casos_RA)<-c("RA de residencia", "Casos")


# names(casos_data_inicio)<-c("Início dos sintomas", "Casos")


casos_data_inicio_formatado<-casos_data_inicio %>%
  dplyr::mutate(data=format(`INICIO DE SINTOMAS`, "%d/%m/%Y")) %>%
  rename(`Início dos sintomas`=`INICIO DE SINTOMAS`,
         Casos=count) %>%
  select(data,Casos) %>%
  filter(!is.na(data))


##Output

CARDS_MONKEY <- list("no. casos" = monkey_cards_casos,
                     "faixa etaria" = casos_faixa_etaria,
                     "sexo" = casos_sexo, "RA" = casos_RA,
                     "data inicio" = casos_data_inicio)

write.xlsx(CARDS_MONKEY, file = "cards_monkey.xlsx")


  
##Quantidade de casos segundo RA
casos_RA <- confirmados %>%
  dplyr::group_by(`RA RESIDENCIA`) %>%
  summarise(count= n())


##Quantidade de casos suspeitos e confirmados por data de inÃ­cio de sintomas

c_s<-rbind(confirmados,suspeitos)

casos_data_inicio <- c_s %>%
  dplyr::group_by(`INICIO DE SINTOMAS`) %>%
  summarise(count = n())

  
##Planilha de dados:
Colunas <- c("Casos Suspeitos", "Casos Descartados", "Casos Confirmados")
Quantidade <- c(nrow(suspeitos), nrow(descartados), nrow(confirmados))
monkey_cards_casos <- data.frame(Colunas, Quantidade)

names(casos_faixa_etaria)<-c("Faixa Etaria", "Casos")


names(casos_sexo)<-c("Sexo", "Casos") 



names(casos_RA)<-c("RA de residencia", "Casos") 


names(casos_data_inicio)<-c("Início dos sintomas", "Casos") 


CARDS_MONKEY <- list("no. casos" = monkey_cards_casos, "faixa etaria" = casos_faixa_etaria, "sexo" = casos_sexo, "RA" = casos_RA, "data inicio" = casos_data_inicio)
write.xlsx(CARDS_MONKEY, file = "cards_monkey.xlsx")

