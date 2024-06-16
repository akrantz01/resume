#import "common.typ": icon

#let format_phone_number(phone) = {
  if phone.starts-with("+") == false {
    panic("Phone number must start with a country code")
  }

  "+" + phone.split(regex("[^0-9]+")).filter(part => part.len() > 0).join("-")
}

#let account_link(base, identifier, full: false) = {
  let base = base.trim("/", at: end) + "/" + identifier
  let text = if full {
    base
  } else {
    identifier
  }
  link("https://" + base, text)
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
  "website": (url: "https://example.com", text: none, ..) => {
    let text = if text == none {
      url
    } else {
      text
    }
    box[
      #icon("website")
      #link(url, text)
    ]
  },
  "github": (username: "john-doe", full: false, ..) => box[
    #icon("github")
    #account_link("github.com", username, full: full)
  ],
  "linkedin": (username: "john-doe", full: false, ..) => box[
    #icon("linkedin")
    #account_link("linkedin.com/in/", username, full: full)
  ],
)

#let header_item((type, ..item)) = box(
  header_items.at(type)(..item),
)

#let header(name, items) = {
  align(
    center,
    block[
      #text(size: 2.25em, font: "Fira Code Retina", name) \
      #items.map(header_item).join(h(1.25em))
    ],
  )
  v(5pt)
}
