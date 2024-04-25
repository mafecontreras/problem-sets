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





























for (dataframe in lista_dataframes) {
  if (grepl("No ocupados", dataframe)) {
    lista_no_ocupados[[dataframe]] <- lista_dataframes[[dataframe]] 
    }
  if (grepl("Ocupados", dataframe)) {
    lista_ocupados[[dataframe]] <- lista_dataframes[[dataframe]] 
  }
  if (grepl("Fuerza de trabajo", nombre_archivo)) {
    lista_fuerza_trabajo[[dataframe]] <- lista_dataframes[[dataframe]]  
  }
}
 


lista_dataframes <- list() 
lista_dataframes <- list(No_ocupados=No_ocupados,
                         Ocupados = Ocupados, 
                         Fuerza_trabajo = Fuerza_trabajo)
print(lista_dataframes)









for(dataframes in lista_dataframes){
  if (grepl("No ocupados", dataframes)) {
    df_no_ocupados <- rbindlist(dataframes, fill = TRUE)
  } 
}
  <- 
  
  rbindlist(lista_dataframes, fill = TRUE)
data_frame_combinado <- as.data.frame(data_frame_combinado)




#############################################
####2. PREPARACION


