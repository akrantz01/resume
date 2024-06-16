#import "common.typ": date-range, icon, section

#let entry(
  title,
  start,
  description: none,
  url: none,
  end: none,
  details: (),
) = {
  let about = if description != none [ *#title*, #emph(description) ] else [ *#title* ]
  let about = if url != none {
    let text = url.href.trim("https://").split("/").slice(1).join("/")
    [
      #about
      #box(
        pad(
          left: 0.5em,
          link(url.href)[
            #icon(url.type)
            #text
          ],
        ),
      )
    ]
  } else {
    about
  }

  set block(above: 0.7em, below: 1em)
  grid(
    columns: (85%, 15%),
    align(left, about), align(right, date-range(start, end)),
  )
  list(..details)
}

#let projects(title: "Projects", ..entries) = {
  section(title)
  entries.pos().map(((title, start, ..rest)) => entry(
    title,
    start,
    ..rest,
  )).join(v(0.25em))
}
