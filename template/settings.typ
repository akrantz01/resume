#let with-defaults(settings) = {
  settings.full-links = settings.at("full-links", default: false)
  settings.locations = settings.at("locations", default: true)
  settings
}

#let ensure-settings(with-settings) = {
  let settings = with-settings.at("settings", default: (:))
  with-settings.settings = with-defaults(settings)
  with-settings
}
