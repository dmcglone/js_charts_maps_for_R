# make leaflet map centered on Jacksonville
leaflet() %>%
  setView(lng = -81.65, lat = 30.3, zoom = 11) %>%
  addTiles()