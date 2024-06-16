#let section(title) = {
  show heading: set text(size: 0.92em, weight: "bold")

  block[
    = #smallcaps(title)
    #v(-2pt)
    #line(length: 100%, stroke: 2pt + black)
  ]
}
