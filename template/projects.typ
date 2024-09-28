#import "common.typ": date-range, icon, section

#let entry(
  title,
  date,
  description: none,
  url: none,
  details: (),
  settings: (:),
) = {
  let about = if description != none [ *#title*, #emph(description) ] else [ *#title* ]
  let about = if url != none {
    let text = if settings.at("full-links", default: false) {
      url.href
    } else {
      url.href.trim("https://", at: start).split("/").slice(1).join("/")
    }

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

  set block(above: 0.7em, below: 0.75em)
  box(width: 100%)[
    #about
    #h(1fr)
    #date-range(date)
  ]
  list(..details)
}

#let projects(title: "Projects", settings: (:), omit: (), ..entries) = {
  section(title)
  entries.pos().filter(((id, ..rest)) => id not in omit).map((
    (id, title, date, ..rest),
  ) => entry(
    title,
    date,
    settings: settings,
    ..rest,
  )).join()
}
