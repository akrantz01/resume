local_typst := invocation_directory() + "/typst"
typst_binary := if path_exists(local_typst) == "true" { local_typst } else { "typst" }

# List the available tasks
list:
  @just --list --unsorted

# Compile the specified layout
compile layout="default": (typst "compile" layout)

# Continuously watch and recompile the specified layout on changes
watch layout="default": (typst "watch" layout)

# Run typst commands
[private]
typst command layout="default":
  {{typst_binary}} {{command}} main.typ {{layout}}.pdf \
    --input layout={{layout}} \
    --font-path ./fonts

# Format and lint the project
lint: typstyle yamllint

# Format all the Typst files
typstyle:
  typstyle format-all

yamllint-format := if env("CI", "false") == "true" { "github" } else { "auto" }

# Lint the YAML files
yamllint:
  yamllint -sf {{yamllint-format}} .
