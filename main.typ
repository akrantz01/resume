#let data = yaml("data.yml")
#let layout = {
  let value = sys.inputs.at("layout", default: none)
  if value == none {
    panic("Missing layout specification in input, set using --input layout=...")
  }

  yaml(value)
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
  title: layout.title,
  author: author,
  keywords: ("resume", "cv"),
)
#set page(
  paper: "a4",
  margin: (x: 0.5cm, y: 0.5cm),
)
#set text(
  size: 9.75pt,
  font: "Montserrat",
)

#set list(indent: 0.5em, marker: [•])
#show link: underline
#show link: set underline(offset: 1.5pt)

#import "template/heading.typ": header
#import "template/overrides.typ": apply-overrides
#import "template/sections.typ": sections
#import "template/settings.typ": ensure-settings

#let layout = ensure-settings(layout)
#let data = apply-overrides(data, layout.at("overrides", default: (:)))

#header(data.author.name, settings: layout.settings, links: data.author.links)
#sections(layout, data)

#place(
  bottom + center,
  dx: 1.5em,
  block[
    #set text(size: 4pt, font: "Fira Code Retina")
    Last updated on #datetime.today().display()
  ],
)
