### SETUP
# Bibliotecas gerais usadas
if(!require(pacman)) {
  install.packages("pacman", dependencies = TRUE);
}
library(pacman)
# Instalando e carregando pacotes
p_load(terra, sf, tidyr, dplyr, remotes, viridis, leaflet)
# install.packages(c("terra", "sf", "tidyr", "dplyr", "remotes", "viridis", "leaflet"))

# remove.packages(c("rlang", "xfun"))
remotes::install_github("sjevelazco/flexsdm") 
# alguns pacotes estavam dando erro ao copiar, a solução foi remover eles 
# (usei a interface do rstudio mas daria pra usar o comando acima), 
# mas não sei se adiantou algo (apenas tirou os erros do log) pois
# também estava dando um erro com "g++", e a solução foi reinstalar o rtools
library(flexsdm)

raster_test <- terra::rast("data/ambiental/thetao_mean_baseline_2000_2019_depthsurf.nc")[[2]]
# tava dando um erro mas reinstalar os pacotes funcionou
writeRaster(raster_test, "data/ambiental/thetao_mean_baseline_2010_2019_depthsurf.tif")

pal <- colorNumeric(palette = "viridis", domain = values(raster_test), na.color = NA)
leaflet() %>%
  addProviderTiles("OpenStreetMap") %>%
  addRasterImage(raster_test, colors = pal, opacity = 0.75) %>%
  addLegend(pal = pal, values = values(raster_test), title = "Relative ocurrence rate")

