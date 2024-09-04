#import "common.typ": format-date, icon, parse-date, section

#let entry(
  name,
  organization,
  on,
  description: none,
  url: none,
  settings: (:),
) = {
  let link = if url != none {
    let item = if settings.full-links [
      #url.text (#link(url.href))
    ] else {
      link(url.href, url.text)
    }

    box(
      move(dx: 0.5em)[
        #icon("website")
        #item
      ],
    )
  }

  set block(above: 0.7em, below: 1em)
  grid(
    columns: (85%, 15%),
    align(left)[
      #strong(name), #emph(organization) #link
    ],
    align(right, format-date(on)),
  )
  if description != none {
    pad(
      left: 1em,
      top: -0.5em,
      box(width: 90%, eval(description, mode: "markup")),
    )
  }
}

#let awards(title: "Awards", settings: (:), ..entries) = {
  section(title)
  entries.pos().map(((id, name, organization, on, ..rest)) => entry(
    name,
    organization,
    on,
    settings: settings,
    ..rest,
  )).join()
}
