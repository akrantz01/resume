#let data = {
  if sys.inputs.at("path", default: none) == none {
    panic("No path to data provided")
  }

  yaml(sys.inputs.path)
}
#let author = {
  let value = data.author.links.find(link => link.type == "email")
  if value != none {
    data.author.name + " <" + value.email + ">"
  } else {
    data.author.name
  }
}

#set document(
  title: data.title,
  author: author,
  keywords: ("resume", "cv"),
)
#set page(
  paper: "a4",
  margin: (x: 0.5cm, top: 0.75cm, bottom: 0.5em),
)
#set text(
  size: 8pt,
  font: "Montserrat",
)

#set list(indent: 1em, marker: [--])
#show link: underline
#show link: set underline(offset: 3pt)

#import "template/awards.typ": awards
#import "template/common.typ": section
#import "template/education.typ": education
#import "template/experience.typ": experience
#import "template/heading.typ": header
#import "template/projects.typ": projects
#import "template/skills.typ": skills

#header(data.author.name, data.author.links)
#education(..data.education)
#experience(..data.experience)
#experience(title: "Volunteering", ..data.volunteering)
#projects(..data.projects)
#awards(..data.awards)
#skills(..data.skills)

#place(bottom + right, dx: 1.5em, block[
  #set text(size: 4pt, font: "Fira Code Retina")
  Last updated on #datetime.today().display()
])
