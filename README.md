# dotfile collection

Just a dotfile collection taylored for easy deployment. The idea is to automate
the whole process of redeploying the environment in case of a sudden urge to
format my computer or in case of new computer.

## dotfiles

The setup is based on Zach Holman's "bootstrap" technique.
[read his wonderful post on the subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## Installation

Run:

```sh
git clone https://github.com/crvs/dotfiles.git ~/.dotfiles
cd ~/.dotfiles/script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

## topical

Just put things in their appropriate topics to keep them organized and save on
headaches

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## Aknowledgements

* [rsrsl](http://github.com/rsrsl) for mentioning this
* [Zach Holman](http://github.com/holman)
* [Ryan Bates](http://github.com/ryanb)
