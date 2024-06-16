#import "common.typ": date-range, section

#let entry(title, start, description: none, end: none, details: ()) = {
  let about = if description != none [ *#title*, #emph(description) ] else [ *#title* ]

  set block(above: 0.7em, below: 1em)
  grid(
    columns: (85%, 15%),
    align(left, about),
    align(right, date-range(start, end)),
  )
  list(..details)
}

#let projects(title: "Projects", ..entries) = {
  section(title)
  entries
    .pos()
    .map(((title, start, ..rest)) => entry(title, start, ..rest))
    .join(v(0.25em))
}
