#import "common.typ": icon

#let format_phone_number(phone) = {
  if phone.starts-with("+") == false {
    panic("Phone number must start with a country code")
  }

  "+" + phone.split(regex("[^0-9]+")).filter(part => part.len() > 0).join("-")
}

#let account_link(base, identifier, full: false) = {
  let base = "https://" + base.trim("/", at: end) + "/" + identifier
  let text = if full {
    base
  } else {
    identifier
  }
  link(base, text)
}

#let header_items = (
  "email": (email: "john@doe.com", ..) => box[
    #icon("email")
    #link("mailto:" + email, email)
  ],
  "phone": (phone: "+1 555 555 5555", ..) => box[
    #icon("phone")
    #link("tel:" + format_phone_number(phone), phone)
  ],
  "website": (settings, url: "https://example.com", ..) => {
    let text = if settings.full-links {
      url
    } else {
      url.trim("https://", at: start)
    }
    box[
      #icon("website")
      #link(url, text)
    ]
  },
  "github": (settings, username: "john-doe", ..) => box[
    #icon("github")
    #account_link("github.com", username, full: settings.full-links)
  ],
  "linkedin": (settings, username: "john-doe", ..) => box[
    #icon("linkedin")
    #account_link("linkedin.com/in/", username, full: settings.full-links)
  ],
)

#let header_item((type, ..item), settings) = box(
  header_items.at(type)(..item, settings),
)

#let header(name, settings: (:), links: ()) = {
  align(
    center,
    block[
      #text(size: 2.25em, font: "Fira Code Retina", name) \
      #{
        set text(size: 8.25pt)
        links.map(args => header_item(args, settings)).join(h(1.25em))
      }
    ],
  )
  v(5pt)
}
