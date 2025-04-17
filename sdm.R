### SETUP
# Bibliotecas gerais usadas
if(!require(pacman)) {
  install.packages("pacman", dependencies = TRUE);
}
library(pacman)
# Instalando e carregando pacotes
p_load(terra, sf, tidyr, dplyr, remotes, viridis, leaflet)

remotes::install_github("sjevelazco/flexsdm") 
library(flexsdm)