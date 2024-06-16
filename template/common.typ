#let section(title) = {
  show heading: set text(size: 0.92em, weight: "bold")

  block[
    = #smallcaps(title)
    #v(-2pt)
    #line(length: 100%, stroke: 2pt + black)
  ]
}

#let date-range(start, end) = {
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
