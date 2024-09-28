// Checks if a string looks like an integer
#let integer-regex = regex("^[0-9]+$")
#let is-integer(value) = {
  if value.match(integer-regex) != none {
    true
  } else {
    false
  }
}

// Converts a key specifier from the layout to a path within the data
#let key-to-path(key) = {
  key.split(".").map(segment => {
    if is-integer(segment) {
      int(segment)
    } else {
      segment
    }
  }).rev()
}

// Recursively updates a value in a nested container using the provided path
#let set-value(parent, path, value) = {
  let key = path.pop()
  let child = parent.at(key)

  if (type(child) == dictionary or type(child) == array) and path.len() > 0 {
    parent.at(key) = set-value(child, path, value)
  } else {
    parent.at(key) = value
  }

  parent
}

// Applies overrides from the layout to the data
#let apply-overrides(data, overrides) = {
  for (key, value) in overrides {
    data = set-value(data, key-to-path(key), value)
  }

  data
}
