#import "common.typ": date-range, section

#let entry(
  school,
  date,
  degree: none,
  area: none,
  location: none,
  gpa: none,
  courses: (),
  extra: none,
  settings: (:),
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

  set block(above: 1em)
  grid(
    columns: (80%, 20%),
    align(left, about), align(right, date-range(date)),
  )
  pad(left: 1.25em, top: -0.45em)[
    #if location != none and settings.locations [ #emph(location) \ ]
    #if extra != none [ #eval(extra, mode: "markup") \ ]
    #if gpa != none [ #text(weight: "medium")[GPA]: #gpa \ ]
    #if courses.len() > 0 [
      #text(weight: "medium")[Courses]: #courses.join(", ") \
    ]
  ]
}

#let education(title: "Education", settings: (:), ..entries) = {
  section(title)
  entries.pos().map(((id, school, date, ..rest)) => entry(
    school,
    date,
    settings: settings,
    ..rest,
  )).join()
}
