# chezmoi_dotfiles

Chezmoi is a dotfile manager. The name literally translates to "at my house"

To install these, choose the appropriate command for your environment:

## Linux/Windows (VS Code)

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply GatlenCulp --exclude=iterm2
```

## macOS

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply GatlenCulp
```

## Chezmoi stages

First, reference [their overview page](https://www.chezmoi.io/user-guide/command-overview/)

## Go Templating Reference

### How chezmoi uses Go data

Chezmoi uses [Go text templating](https://pkg.go.dev/text/template). [This guide](https://gohugo.io/templates/introduction/) is pretty nice.

You can see all the template data available by running `chezmoi data --format yaml`. These variables appear in two places:

- for all source files containing `*.tmpl`. When they are rendered all `{{ .chezmoi.some-variable }}` will be filled in.
- for all arguments to chezmoi commands. Ex: `chezmoi execute-template '{{ .chezmoi | toToml }}'`

You can feed files in:

```bash
chezmoi execute-template --init < '/Users/gat/.local/share/chezmoi/chezmoi.toml.tmpl'
```

### Reference

`{{ $osid }}` would output: linux-debian
`{{ $osid | quote }}` would output: "linux-debian"
