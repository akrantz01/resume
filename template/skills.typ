#import "common.typ": section

#let skills(title: "Skills", ..entries) = {
  section(title)

  block(
    above: 0.7em,
    below: 1em,
    entries.named().pairs().map(((name, list)) => box[
      *#name*:
      #list.join(", ")
    ]).join(v(-0.25em)),
  )
}
