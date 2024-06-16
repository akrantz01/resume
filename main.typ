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

#import "template/heading.typ": header
#import "template/sections.typ": sections

#header(data.author.name, data.author.links)
#sections(data.sections)

#place(bottom + right, dx: 1.5em, block[
  #set text(size: 4pt, font: "Fira Code Retina")
  Last updated on #datetime.today().display()
])
