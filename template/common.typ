#let section(title) = {
  show heading: set text(size: 0.92em, weight: "bold")

  block[
    = #smallcaps(title)
    #v(-2pt)
    #line(length: 100%, stroke: 2pt + black)
  ]
}

#let icon(name) = box(height: 9pt, move(dx: -2pt, dy: 2pt, image("icons/" + name + ".svg")))

#let parse-date(raw) = {
  if raw == none {
    return none
  } else if type(raw) == datetime {
    return raw
  }

  let parts = raw.split("-")
  if parts.len() != 3 {
    panic("Invalid date format")
  }

  let year = int(parts.at(0))
  let month = int(parts.at(1))
  let day = int(parts.at(2, default: 15))

  datetime(year: year, month: month, day: day)

}

#let date-range(start, end) = {
  let start = parse-date(start)
  let end = parse-date(end)

  if end == none [
    #start.display("[month repr:short] [year]") - Present
  ] else if start > end {
    panic("Start date is after end date")
  } else if start.year() == end.year() {
    if start.month() == end.month() {
      start.display("[month repr:short] [year]")
    } else [
      #start.display("[month repr:short]") - #end.display("[month repr:short] [year]")
    ]
  } else [
    #start.display("[month repr:short] [year]") - #end.display("[month repr:short] [year]")
  ]
}
