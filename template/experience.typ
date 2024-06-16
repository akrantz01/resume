#import "common.typ": date-range, section

#let entry(company, title, date, location: none, highlights: ()) = {
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (80%, 20%),
    align(left)[
      #strong(company), #emph(title) \
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

#let experience(title: "Experience", ..entries) = {
  section(title)
  entries.pos().map(((company, title, date, ..rest)) => entry(
    company,
    title,
    date,
    ..rest,
  )).join(v(0.25em))
}
