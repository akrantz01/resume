#import "common.typ": date-range, parse-date, section

#let entry(name, organization, on, description: none) = {
  let on = parse-date(on)

  set block(above: 0.7em, below: 1em)
  grid(
    columns: (85%, 15%),
    align(left)[#strong(name), #emph(organization)],
    align(right)[#on.display("[month repr:short] [year]")]
  )
  if description != none {
    pad(left: 1em, top: -0.5em, box(width: 90%, eval(description, mode: "markup")))
  }
}

#let awards(title: "Awards", ..entries) = {
  section(title)
  entries
    .pos()
    .map(((name, organization, on, ..rest)) => entry(name, organization, on, ..rest))
    .join(v(0.25em))
}
