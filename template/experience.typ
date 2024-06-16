#import "common.typ": date-range, section

#let entry(company, title, start, end: none, location: none, highlights: ()) = {
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (80%, 20%),
    align(left)[
      #strong(company), #emph(title) \
      #list(..highlights)
    ],
    align(right)[
      #date-range(start, end) \
      #if location != none { emph(location) }
    ],
  )
}

#let experience(title: "Experience", ..entries) = {
  section(title)
  entries
    .pos()
    .map(((company, title, start, ..rest)) => entry(company, title, start, ..rest))
    .join(v(0.25em))
}
