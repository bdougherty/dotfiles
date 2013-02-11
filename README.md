# Brad's dotfiles

## Installation

```bash
git clone git://github.com/bdougherty/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && source bootstrap.sh
```

To update, `cd` into `~/.dotfiles` and then:

```bash
source bootstrap.sh
```

### Install OS X preferences

When setting up a new Mac, running this script will set up my preferred OS X preferences:

```bash
./osx.sh
```

### Install Homebrew formulas

When setting up a new Mac, run this to install some common Homebrew formulas:

```bash
./brew.sh
```

## Thanks to…

[Mathias Bynens](https://github.com/mathiasbynens/dotfiles/), [Paul Irish](https://github.com/paulirish/dotfiles), and [Ben Alman](https://github.com/cowboy/dotfiles) for inspiration.