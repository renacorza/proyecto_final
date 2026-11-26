
## Script 01 - Limpieza de la base de datos ------------------------------------

# Renato Cortez y Constanza Pinilla
# 26-11-2026

## Carga de paquetes -----------------------------------------------------------

library(dplyr)
library(tidyverse)
library(tidyr)
library(broom)
library(haven)

## Carga de datos --------------------------------------------------------------

datos_exp <- read.csv2("data/raw/salida_da_10_2026.csv")

names(datos_exp)
ncol(datos_exp)
dim(datos_exp)
str(datos_exp)

## Limpieza de datos -----------------------------------------------------------

sum(is.na(datos_exp$PESO_BRUTO_KG))    # Hay 431 NA en el peso bruto
unique(datos_exp$COD_VIA_TRANSPORTE)   # Hay un 0 que no tiene correspondencia
                                       # en la tabla de códigos.

unique(datos_exp$COD_TIPO_CARGA)       # Hay una S que no tiene correspondencia
                                       # en la tabla de códigos además de espacios
                                       # vacíos mostrados como "".

exp_limpio <-
  datos_exp |> 
  select(MES, COD_VIA_TRANSPORTE, COD_PAIS_DESTINO, COD_TIPO_CARGA, PESO_BRUTO_KG) |> 
    rename_with(tolower) |>
    filter(!is.na(peso_bruto_kg) &
           cod_via_transporte != 0 &
           cod_tipo_carga != "S" &
           cod_tipo_carga != "") |> 
    mutate(mes_txt = case_when(
             mes == 1 ~ "Enero",
             mes == 2 ~ "Febrero",
             mes == 3 ~ "Marzo",
             mes == 4 ~ "Abril",
             mes == 5 ~ "Mayo",
             mes == 6 ~ "Junio",
             mes == 7 ~ "Julio",
             mes == 8 ~ "Agosto",
             mes == 9 ~ "Septiembre",
             mes == 10 ~ "Octubre"),
           transporte = case_when(
             cod_via_transporte == 1  ~ "Marítima, fluvial y lacustre",
             cod_via_transporte == 4  ~ "Aéreo",
             cod_via_transporte == 5  ~ "Postal",
             cod_via_transporte == 7  ~ "Terrestre",
             cod_via_transporte == 8  ~ "Oleoductos, gasoductos",
             cod_via_transporte == 9  ~ "Tendido eléctrico",
             cod_via_transporte == 10 ~ "Otra",
             cod_via_transporte == 11 ~ "Courier"),
           pais_destino = case_when(
             cod_pais_destino == 225 ~ "EEUU",
             cod_pais_destino == 219 ~ "Perú",
             cod_pais_destino == 224 ~ "Argentina",
             cod_pais_destino == 220 ~ "Brasil",
             cod_pais_destino == 202 ~ "Colombia",
             cod_pais_destino == 336 ~ "China",
             cod_pais_destino == 216 ~ "México",
             cod_pais_destino == 218 ~ "Ecuador",
             cod_pais_destino == 221 ~ "Bolivia",
             cod_pais_destino == 331 ~ "Japón",
             TRUE ~ "Resto del mundo"),
           tipo_carga = case_when(
             cod_tipo_carga == "F" ~ "Frigorizados",
             cod_tipo_carga == "G" ~ "Granel sólido",
             cod_tipo_carga == "L" ~ "Granel líquido o gaseoso",
             cod_tipo_carga == "O" ~ "Electricidad",
             cod_tipo_carga == "R" ~ "General"))


# Se excluyeron los registros correspondientes a las categorías "S" y "" de la variable 
# COD_TIPO_CARGA y un "0" de la variable COD_VIA_TRANSPORTE debido a que no fue 
# posible identificar su correspondencia en la tabla de codificación utilizada.
# También se excluyeron los 431 valores perdidos de la variable PESO_BRUTO_KG y 
# se eligieron los 10 países a los que más se les exporta.
# Con estas decisiones se busca trabajar con categorías de carga identificables 
# y comparables para el análisis descriptivo y la estimación del modelo de regresión.

## Modelo de prueba ------------------------------------------------------------

exp_limpio |> 
  lm(log(peso_bruto_kg) ~ transporte + pais_destino + tipo_carga, data = _) |> 
  tidy(conf.int = TRUE) |>
  print(n=21)

## Guardado de base limpia -----------------------------------------------------

dir.create("data/processed", showWarnings = FALSE)
write.csv(exp_limpio, "data/processed/exportaciones_limpio.csv", row.names = FALSE)
write_dta(exp_limpio, "data/processed/exportaciones_limpio.dta")

file.exists("data/processed/exportaciones_limpio.csv")
file.exists("data/processed/exportaciones_limpio.dta")

