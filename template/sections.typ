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

#let sections(data) = {
  for section in data {
    let renderer = types.at(section.type)

    renderer(title: section.title, ..section.arguments)
  }
}
