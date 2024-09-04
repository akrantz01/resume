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

  set block(above: 0.7em, below: 0.75em)
  grid(
    columns: (80%, 20%),
    align(left)[
      #strong(company), #emph(title) #link \
      #list(..highlights)
    ],
    align(right)[
      #date-range(date) \
      #if location != none {
        emph(location)
      }
    ],
  )
}

#let experience(title: "Experience", settings: (:), omit: (), ..entries) = {
  section(title)
  entries
    .pos()
    .filter(((id, ..rest)) => id not in omit)
    .map(((id, company, title, date, ..rest)) => entry(
      company,
      title,
      date,
      settings: settings,
      ..rest,
    ))
    .join()
}
