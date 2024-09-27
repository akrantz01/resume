#import "common.typ": date-range, icon, section

#let entry(
  company,
  title,
  date,
  location: none,
  url: none,
  highlights: (),
  settings: (:),
) = {
  let link = if url != none {
    let text = if settings.full-links {
      url
    } else {
      url.trim("https://", at: start)
    }

    box(
      move(dx: 0.5em)[
        #icon("website")
        #link(url, text)
      ],
    )
  }

  set block(above: 0.95em, below: 0.95em)
  grid(
    columns: (60%, 40%),
    align(left)[
      #strong(company), #emph(title) #link
    ],
    align(right)[
      #if location != none and settings.locations [
        #emph(location) --
      ]
      #date-range(date)
    ],
  )
  list(..highlights)
}

#let experience(title: "Experience", settings: (:), omit: (), ..entries) = {
  section(title)
  entries.pos().filter(((id, ..rest)) => id not in omit).map((
    (id, company, title, date, ..rest),
  ) => entry(
    company,
    title,
    date,
    settings: settings,
    ..rest,
  )).join()
}
