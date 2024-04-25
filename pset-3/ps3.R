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
  if (grepl("No ocupados", nombre_archivo)) {
    No_ocupados <- data.frame(readRDS(nombre_archivo))
  }
  if (grepl("No ocupados", nombre_archivo)) {
    Ocupados <- data.frame(readRDS(nombre_archivo))
  }
  if (grepl("No ocupados", nombre_archivo)) {
    Fuerza_trabajo <- data.frame(readRDS(nombre_archivo))
  }
}

lista_dataframes <- list(No_ocupados=No_ocupados,
                         Ocupados = Ocupados, 
                         Fuerza_trabajo = Fuerza_trabajo)
print(lista_dataframes)

#1.3

data_frame_combinado <- rbindlist(lista_dataframes)
data_frame_combinado <- as.data.frame(data_frame_combinado)


#############################################
####2. PREPARACION


