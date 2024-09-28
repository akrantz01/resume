#let read-layout(name) = yaml("../layouts/" + name + ".yml")

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

#let deep-merge(dict1, dict2) = {
  let final = dict1
  for (k, v) in dict2 {
    if (k in dict1) {
      if type(v) == "dictionary" {
        final.insert(k, deep-merge(dict1.at(k), v))
      } else {
        final.insert(k, dict2.at(k))
      }
    } else {
      final.insert(k, v)
    }
  }
  final
}

#let process-extends(layout) = {
  let extends = layout.remove("extends", default: none)
  if extends == none {
    return layout
  }

  let parent = read-layout(extends)
  let merged = deep-merge(parent, layout)
  process-extends(merged)
}

#let load-layout(name) = {
  if name == none {
    panic("Missing layout specification in input, set using --input layout=...")
  }

  let raw = read-layout(name)
  let layout = process-extends(raw)
  let with-settings = ensure-settings(layout)
  with-settings
}
