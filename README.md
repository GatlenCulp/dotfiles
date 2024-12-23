# Gatlen's dotfiles

**_My `~/.config` macos configuration for nerdy things like zshrc and jazz_**

_Last updated: 2024 December 22_

![GitHub stars](https://img.shields.io/github/stars/gatlenculp/dotfiles?style=social)


<div align="center">
  <a href="https://dotfiles.github.io/">
    <img src="./docs/dotfiles-logo.png" alt="dotfiles logo" style="max-width: 250px;"/>
  </a>
  <br/>
  <b>Gatlen's <a href="https://dotfiles.github.io/">dotfiles</a></b>
  <br/>
</div>
<br>

I love configuring my machine and tools to work exactly the way I want them to and decided to post my dotfiles to github for back-up/learning/sharing. Feel free to take any of this setup and make it your own.

This might not be the most useful way to spend my time but I find it kind of relaxing, similar to [bullet-journaling](https://hips.hearstapps.com/hmg-prod/images/img-20200415-110729-1586974804.jpg) but for software engineers and nerds.

## Features 📦

_Note: You won't find Vim here sorry_

### 00 Installers 🍺

I tend to use [Homebrew](https://brew.sh/) for essentially everything where possible. Homebrew takes care of upgrades, uninstalls, etc. It's nice to keep things centralized like this. I don't have all my homebrew package/app installs here but might add them later. You can check out an incomplete set of apps I use [on stackshare](https://stackshare.io/gatlenculp/my-stack).

### 01 ZSH & BASH Setup 🐚

ZShell is my go-to since it's approximately fully-compatible with BASH and is default on MacOS. I do add some customizations to it though using [Oh My ZSH](https://ohmyz.sh/), the community go-to for ZSH plugins and configuration.

If a configuration is agnostic to BASH/ZSH, I just label it as `sh` instead of `zsh` or `bash`.

[`.shrc`](./.shrc) and [`shrc/`](./shrc/) - General shell configuration. `.shrc` is the entry point which calls scripts in `shrc/`.

[`.zshrc`](./.zshrc), [`zshrc/`](./zshrc/), [`.bashrc`](./.bashrc), and [`bashrc/`](./bashrc/) are the same but shell-specific. These rc files call `.shrc` for general setup.

[`.exports`](./.exports) -- Global Environment Variables
[`.aliases`](./.aliases) -- Command Aliases (basically short functions)
[`.functions`](./.functions) -- Helper functions

**Linking real and fake rcs**

BASH/ZSH don't use `~/.config/.{ba, z}shrc` for their rc files and instead use `~/.{ba, z}shrc`, so the real rc files just source my rc files in `~/.config`:
```bash
source $HOME/.config/.zshrc
```

I could symlink the files, but I lightly prefer this setup since many tools will ask you to add something to your rc file like `echo 'start tool' >> ~/.zshrc` and sometimes I'm lazy and will just do that and organize it into the proper place later when I decide I want to make it a part of my permanent config.

**Other Shells**

I'm currently exploring other shells like [Nushell](https://www.nushell.sh/) (gorgeous, data-driven, and fast) and [Xonsh](https://xon.sh/) (Python shell, also wonderful).

I think [FISH](https://fishshell.com/) is nice but I've strayed away from it because if I'm going to use a shell that's POSIX incompatible and has some extra stuff to learn I might as well just jump to the most modern tooling I guess.

### 02 Prompt Customization ❓

<div align="center">
    <img src="./docs/prompt.png" alt="prompt"/>
  <br/>
  Gatlen's Prompt
  <br/>
</div>
<br>

I use [Oh My Posh](https://ohmyposh.dev/) for my command line prompt. I use this over [powerlevel10k](https://github.com/romkatv/powerlevel10k) (with [Oh My ZSH](https://ohmyz.sh/)) and more traditional tools because it's shell-independent, easily customizable, and well documented. I've used powerlevel and other tools prior to Oh My Posh and low-key they're bit annoying to setup.

Another alternative to Oh My Posh is [Starship](https://starship.rs/) which somehow got even more popular than Oh My Posh? It's very similar, I think is a bit faster and has some additional features or something but I haven't played with it and it wasn't around when I first made my prompt.

Configuration can be found in [oh-my-posh](./oh-my-posh/). I'm currently using [nordcustom_v.3.omp.json](oh-my-posh/themes/nordcustom_v.3.omp.json)

### 03 Command Line Utilities 🛠️

### 04 Nerd Font 💬

[Fira Code Nerd Font](https://github.com/Trzcin/Fira-Code-Nerd) is my go-to font for literally everything. The monospace, ligatures, universal availability, and options just make it \*mwah\*. (Like it is literally on Google Fonts and you can use it as the default font in Google Collab. There's an extension for it in VSCode. It's just everywhere and I low-key love it so no complaints here.)


## Security 🔒

```
┌─○───┐
│ │╲  │
│ │ ○ │
│ ○ ░ │
└─░───┘
```

Since this is on my actual `~/.config` folder and god know what tool wants to save private info here, I try my best to keep secrets from accidentally getting uploaded publicly.

This repo is protected with [gitleaks](https://github.com/gitleaks/gitleaks) and [pre-commit](https://pre-commit.com/) hooks. I use an additive rather than subtractive strategy for my [.gitignore](./.gitignore) file, adding folders as needed.


## Copyright ©️

No private code is being posted here but this is a low-key project and I don't have time to make contributions to every tool I use or open-source repo I clone into it (ex: [Dracula themes](https://draculatheme.com/)). Feel free to take whatever you want from this repo and make it your own but I make no guarentees about its functionality or quality.

A decent chunk of these dotfiles were taken from another common dotfiles repo: https://github.com/mathiasbynens/dotfiles

I agree with the author here:
> Warning: If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!


## Random Notes 📝

### 00 To do/try ✅
- [ ] [rcm (rc file management)](https://github.com/thoughtbot/rcm) looks like an interesting tool but I just learned about it and not ready to go down another rabbit hole
- [ ] As mentioned above, I want to understand [Starship](https://starship.rs/)'s differences from [Oh My Posh](https://ohmyposh.dev/)
- [ ] Not a huge fan of the right-side second prompt since it breaks after resizing the terminal window. Might remove.
- [ ] Try out the terminal multiplexer [Zellij](https://zellij.dev/) more. I never really got into terminal multiplexing and since I use VSCode/Cursor for my programming, I have always had windows to drag around so I don't know if I actually need it.

### 01 Why Not Vim 🤡

I tried getting into [[Neo]Vim](https://neovim.io/) back in high school and installing extension after extension to make it usable and learning all the commands but it was such a rabbit hole and I don't know if I want to get into it again. Especially since VSCode/Cursor is so compatible with everything out of the box and has a lot of nice features and gui and is easy to make extensions for and work remotely and work with jupyter notebooks and yada yada.

There's a ton of "post-modern" Vim-like terminal-based tools like [Helix](https://helix-editor.com/) as well as preconfigured Neovim IDE distributions (ex: [LunarVim](https://www.lunarvim.org/), [NvChad](https://nvchad.com/), [AstroVim](https://astronvim.com/), and [LazyVim](https://www.lazyvim.org/)) and I don't think this is the worst time to get into this but god damn is it a time sink. I don't know what the ecosystem looks like now but I remember if you wanted to download plugins you had to choose between 8 different Vim package managers and if you wanted to write a plugin you had to use [VimScript](https://learnvimscriptthehardway.stevelosh.com/): a whole ass ugly language JUST for writing plugins. Considering the inevitability of having to do some amount of editing via the command line I might install LunarVim just for that.


### 02 What's up with Rust? 🦀

There's a whole joke about
