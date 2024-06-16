#import "common.typ": date-range, section

#let entry(
  school,
  date,
  degree: none,
  area: none,
  location: none,
  gpa: none,
  courses: (),
) = {
  if area != none and degree == none {
    panic("An area of study must be accompanied by a degree")
  }

  let about = if degree != none [
    #strong(school),
    #emph(if area != none {
      degree + " in " + area
    } else {
      degree
    })
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
      #date-range(date) \
      #if location != none {
        emph(location)
      }
    ],
  )
}

#let education(title: "Education", ..entries) = {
  section(title)
  entries.pos().map(((school, date, ..rest)) => entry(
    school,
    date,
    ..rest,
  )).join(v(0.25em))
}
