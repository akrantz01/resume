#import "common.typ": section

#let skills(title: "Skills", ..entries) = {
  section(title)

  block(
    above: 0.7em, 
    below: 1em, 
    entries
      .pos()
      .map(((name, skills)) => box[
        *#name*:
        #skills.join(", ")
      ])
      .join(v(-0.25em))
  )
}
