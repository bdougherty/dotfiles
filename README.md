# Brad’s Dotfiles

My dotfiles, powered by [Dotbot](https://github.com/anishathalye/dotbot).

## Installation

First, clone the repo into `~/.dotfiles`:

```shell
git clone https://github.com/bdougherty/dotfiles.git .dotfiles
cd .dotfiles
```

Then run the installer with optional extra configs. For servers, run:

```shell
./install
```

For Macs, run:

```shell
./install mac asdf
```

`mac` will install Homebrew and associated packages and `asdf` will install node and python via asdf.

For Linux distros that use apt, run:

```shell
./install linux asdf
```

## Local Customizations

There are a number of hooks to make local customizations:

* `git`: `~/.gitconfig.local`
* `zsh` and `bash`: `~/.shell.local.before` / `~/.shell.local.after` to run before or after the main profile
* `bash` only: `~/.bashrc.local.before` / `~/.bashrc.local.after` to run before or after the main bash profile
* `zsh` only: `~/.zshrc.local.before` / `~/.zshrc.local.after` to run before or after the main zsh profile

## License

MIT © [Brad Dougherty](https://brad.is)
