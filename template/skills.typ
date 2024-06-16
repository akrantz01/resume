#import "common.typ": section

#let capitalize(name) = {
  name
    .split("-")
    .map(part => {
      if part == "and" {
        "&"
      } else {
        upper(part.slice(0, count: 1)) + part.slice(1)
      }
    })
    .join(" ")
}

#let skills(title: "Skills", ..entries) = {
  section(title)

  block(
    above: 0.7em, 
    below: 1em, 
    entries
      .named()
      .pairs()
      .map(((name, list)) => {
        box[
          *#capitalize(name)*:
          #list.join(", ")
        ]
      })
      .join(v(-0.25em))
  )
}
