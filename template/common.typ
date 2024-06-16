#let section(title) = {
  show heading: set text(size: 0.92em, weight: "bold")

  block[
    = #smallcaps(title)
    #v(-2pt)
    #line(length: 100%, stroke: 2pt + black)
  ]
}

#let icon(name) = box(
  height: 9pt,
  move(dx: -2pt, dy: 2pt, image("icons/" + name + ".svg")),
)

#let parse-date(raw) = {
  if raw == none {
    return none
  }

  let parts = raw.split("-")
  if parts.len() < 2 {
    panic("Invalid date format")
  }

  let year = int(parts.at(0))
  let month = int(parts.at(1))
  let day = int(parts.at(2, default: 15))

  datetime(year: year, month: month, day: day)
}

#let format-date(date, year: true) = {
  if date == none {
    return none
  } else if type(date) != datetime {
    date = parse-date(date)
  }

  let format = "[month repr:short]"
  if year {
    format += " [year]"
  }

  date.display(format)
}

#let date-range(range) = {
  let start = parse-date(range.start)
  let end = parse-date(range.at("end", default: none))

  if end == none [
    #format-date(start) - Present
  ] else if start > end {
    panic("Start date is after end date")
  } else if start.year() == end.year() {
    if start.month() == end.month() {
      format-date(start)
    } else [
      #format-date(start, year: false) - #format-date(end)
    ]
  } else [
    #format-date(start) - #format-date(end)
  ]
}
