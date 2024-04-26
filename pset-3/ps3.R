
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

# Lista para almacenar los resultados de cada ciclo
results <- list()

ciclo_fuerza <- list()
ciclo_ocupados <- list()
ciclo_no_ocupados <- list()

# Ciclo para la base de fuerza de trabajo
for (mes in unique(df_fuerza_trabajo$MES)){
  datos_fuerza <- subset(df_fuerza_trabajo, FT == 1 & PET == 1 & MES == mes, select = c(FT, PET, FEX_C18))
  suma_fuerza <- colSums(datos_fuerza)
  ciclo_fuerza[[length(ciclo_fuerza) + 1]] <- data.frame(
    Mes = mes,
    Poblacion_en_edad_de_trabajar = suma_fuerza['PET'],
    Fuerza_laboral = suma_fuerza['FT']
  )
}

# Ciclo para la base de ocupados
for (mes in unique(df_ocupados$MES)){
  datos_ocupados <- subset(df_ocupados, FT==1 & MES == mes, select = c(FT, FEX_C18))
  suma_ocupados <- colSums(datos_ocupados)
  ciclo_ocupados[[length(ciclo_ocupados) + 1]] <- data.frame(
    Mes = mes,
    Ocupados = suma_ocupados['FT']
  )
}

# Ciclo para la base de no ocupados (desempleados)
for (mes in unique(df_ocupados$MES)){
  datos_no_ocupados <- subset(df_no_ocupados, DSI==1 & MES == mes, select = c(DSI, FEX_C18))
  suma_no_ocupados <- colSums(datos_no_ocupados)
  ciclo_no_ocupados[[length(ciclo_no_ocupados) + 1]] <- data.frame(
    Mes = mes,
    Desempleados = suma_no_ocupados['DSI']
  )
}

f_no_ocupados <- rbindlist(ciclo_no_ocupados, fill = TRUE)
f_ocupados <- rbindlist(ciclo_ocupados, fill = TRUE)
f_fuerza_trabajo <- rbindlist(ciclo_fuerza, fill = TRUE)

#2.2
#Pongo todas en el mismo formato
f_no_ocupados$Mes <- as.character(f_no_ocupados$Mes)
f_ocupados$Mes <- as.character(f_ocupados$Mes)
f_fuerza_trabajo$Mes <- as.character(f_fuerza_trabajo$Mes)

# Combinar los data frames
output <- f_fuerza_trabajo %>%
  full_join(f_ocupados, by = "Mes") %>%
  full_join(f_no_ocupados, by = "Mes")

# Ver el resultado
print(output)





