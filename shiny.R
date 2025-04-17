### SETUP
# Bibliotecas gerais usadas
if(!require(pacman)) {
  install.packages("pacman", dependencies = TRUE);
}
library(pacman)
# Instalando e carregando pacotes
p_load(shiny, bslib, terra, leaflet, viridis)

# Definindo UI
ui <- page_sidebar(
  title = "lema sdm",
  sidebar = sidebar(),
  leafletOutput("sdm_map")
)

# Definindo servidor
server <- function(input, output, session) {
  # Arquivo teste para desenvolvimento (substituindo os resultados dos modelos)
  raster_test <- terra::rast("data/ambiental/thetao_mean_baseline_2010_2019_depthsurf.tif")

  output$sdm_map <- renderLeaflet({
    # ficar atento para aquele possível bug da paleta de cores, está certo dessa forma? apenas verificar
    # o certo é usar dessa forma, colors=pal, mas parecia naquela ocasião que usar colors="viridis" funcionava melhor
    pal <- colorNumeric(palette = "viridis", domain = values(raster_test), na.color = NA)

    leaflet() %>%
      addProviderTiles("OpenStreetMap") %>%
      addRasterImage(raster_test, colors = pal, opacity = 0.75) %>%
      addLegend(pal = pal, values = values(raster_test), title = "Relative ocurrence rate")
  })
}

# Criando o aplicativo
shinyApp(ui = ui, server = server)