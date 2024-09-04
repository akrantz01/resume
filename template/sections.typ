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
  let settings = layout.at("settings", default: (:))

  for section in layout.sections {
    let renderer = types.at(section.type)

    let title = section.at("title", default: none)
    if title == none {
      title = upper(section.id.slice(0, count: 1)) + section.id.slice(1)
    }

    renderer(
      title: title,
      settings: settings,
      omit: section.at("omit", default: ()),
      ..data.at(section.id, default: ()),
    )
  }
}
