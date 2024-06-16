#import "common.typ": date-range, icon, section

#let entry(
  title,
  date,
  description: none,
  url: none,
  details: (),
) = {
  let about = if description != none [ *#title*, #emph(description) ] else [ *#title* ]
  let about = if url != none {
    let text = url.href.trim("https://", at: start).split("/").slice(1).join("/")
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
    align(left, about), align(right, date-range(date)),
  )
  list(..details)
}

#let projects(title: "Projects", ..entries) = {
  section(title)
  entries.pos().map(((title, date, ..rest)) => entry(
    title,
    date,
    ..rest,
  )).join(v(0.25em))
}
