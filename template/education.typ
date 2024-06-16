#import "common.typ": section

#let entry(school, start, end, degree: none, area: none, location: none, gpa: none, courses: (), ..body) = {
  if area != none and degree == none {
    panic("An area of study must be accompanied by a degree")
  }

  let body = body.pos()
  let about = if degree != none [
    #strong(school),
    #emph(
      if area != none { degree + " in " + area } else { degree }
    )
  ] else {
    strong(school)
  }

  set block(above: 0.7em)
  grid(
    columns: (80%, 20%),
    align(left)[
      #about \
      #pad(left: 1em)[
        #if gpa != none [ #text(weight: "medium")[GPA]: #gpa \ ]
        #if courses.len() > 0 [
          #text(weight: "medium")[Courses]: #courses.join(", ")
        ]
      ]
    ],
    align(right)[
      #start.display("[month repr:short] [year]") - #end.display("[month repr:short] [year]") \
      #if location != none { emph(location) }
    ],
  )
}

#let education(title: "Education", ..entries) = {
  section(title)
  entries
    .pos()
    .map(((school, start, end, ..rest)) => entry(school, start, end, ..rest))
    .join(v(0.25em))
}
