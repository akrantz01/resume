#import "awards.typ": awards
#import "education.typ": education
#import "experience.typ": experience
#import "projects.typ": projects
#import "skills.typ": skills

#let types = (
  "awards": awards,
  "education": education,
  "experience": experience,
  "projects": projects,
  "skills": skills,
)

#let sections(layout, data) = {
  for section in layout {
    let renderer = types.at(section.type)

    let title = section.at("title", default: none)
    if title == none {
      title = upper(section.id.slice(0, count: 1)) + section.id.slice(1)
    }

    renderer(title: title, ..data.at(section.id, default: ()))
  }
}
