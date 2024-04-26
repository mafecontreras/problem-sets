########################################
##                                    ##
##  TALLER DE R. ECON-1302            ##
##       PROBLEM SET 2                ##
##                                    ##
##  David Florez-202212347            ##
## Maria Contreras-202014039          ##
##Lina Ramos-201921142                ##
## R version 4.3.1 (2023-06-16 ucrt)  ##
##                                    ##
########################################

##set up
rm(list=ls())

##Instalar y llamar librerías
require(pacman)

p_load(tidyverse, rio, skimr, janitor, haven, data.table) 


#############################################
####1. BUCLES

#1.1 Lista de archivos
nombres_archivos <- list.files(path = "pset-3/input", full.names = TRUE, recursive = TRUE)
print(nombres_archivos)

#1.2 Importar archivos
lista_dataframes <- list() 
for (nombre_archivo in nombres_archivos) {
  if (grepl("No ocupados|Ocupados|Fuerza de trabajo", nombre_archivo)) {
    lista_dataframes[[nombre_archivo]] <- readRDS(nombre_archivo)
  }
}

print(lista_dataframes)

#1.3

nombres_df <- names(lista_dataframes)

lista_no_ocupados <- list()
lista_ocupados <- list()
lista_fuerza_trabajo <- list()

for (nombre in nombres_df) {
  contenido_dataframe <- lista_dataframes[[nombre]]
  
  if (grepl("No ocupados", nombre)) {
    lista_no_ocupados[[nombre]] <- contenido_dataframe
  } 
  if (grepl("Ocupados", nombre)) {
    lista_ocupados[[nombre]] <- contenido_dataframe
  }
  if (grepl("Fuerza de trabajo", nombre)) {
    lista_fuerza_trabajo[[nombre]] <- contenido_dataframe
  }
}

# Finalmente, combinamos los data frames de cada categoría en un solo data frame
df_no_ocupados <- rbindlist(lista_no_ocupados, fill = TRUE)
df_ocupados <- rbindlist(lista_ocupados, fill = TRUE)
df_fuerza_trabajo <- rbindlist(lista_fuerza_trabajo, fill = TRUE)


#############################################
###punto 2.1
datos_fuerza <- subset(df_fuerza_trabajo, FT == 1 & PET == 1, select = c(FT, PET, FEX_C18))
suma_variables <- colSums(datos_fuerza)
print(suma_variables)
datos_fuerza2 <- subset(df_fuerza_trabajo, FT == 1 & PET == 1, select = c(FT, PET, FEX_C18, MES))##cogemos este para hacer la tabla 2.2
##
datos_ocupados <- subset(df_ocupados, FT==1, select =c(FT, FEX_C18))
suma_variables <- colSums(datos_ocupados)
print (suma_variables)
datos_ocupados2 <- subset(df_ocupados, FT==1, select =c(FT, FEX_C18, MES))
##
datos_no_ocupados <- subset(df_no_ocupados, DSI==1, select = c(DSI, FEX_C18))
suma_variables <- colSums(datos_no_ocupados)
print (suma_variables)
datos_no_ocupados2 <- subset(df_ocupados, FT==1, select =c(FT, FEX_C18, MES))

##punto 2.2
merged_data <- rbind(datos_no_ocupados2, datos_ocupados2, datos_fuerza2, fill=TRUE)
print(merged_data)

##punto 2.3
num_filas<-nrow(datos_no_ocupados)
print(num_filas) 
##
num_filas2 <-nrow(df_fuerza_trabajo)
print(num_filas2)

##
division<-num_filas/num_filas2
print(division)
##para generar la tasa de desempelo utilizamos la variable DSI y la dividimos por
##el numero de filas de dt_fuerza_laboral, lo que nos indica una tasa de 0.7 de desempleo


##
tasadesempleo<-nrow(datos_ocupados)
print(tasadesempleo) 
##
num_filas2 <-nrow(datos_fuerza)
print(num_filas2)

##
tasaocupacion <-num_filas/num_filas2
print(tasaocupacion)
##para generar la tasa de ocupacion utilizamos los datos de ocupados y la dividimos por
##el numero de filas de datos_fuerza, lo que nos indica una tasa de 0.88 de ocupacion

##punto 3
library(tidyr)

# Supongamos que tus datos se llaman "datos_tasas"
datos_tasas_wide <- pivot_wider( names_from = "Mes", values_from = c("tasadesempleo", "tasaocupacion"))
library(ggplot2)

ggplot(datos_tasas_wide, aes(x = Mes)) +
  geom_line(aes(y = Tasa_Desempleo, color = "Desempleo"), size = 1) +
  geom_line(aes(y = Tasa_Ocupacion, color = "Ocupacion"), size = 1) +
  labs(x = "Mes", y = "Tasa (%)", color = "Variable") +
  scale_color_manual(values = c("Desempleo" = "red", "Ocupacion" = "blue")) +
  theme_minimal()






