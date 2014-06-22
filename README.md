# crvs's dotfile collection

as of now this is just a clone of [rsrsl](http://github.com/rsrsl)'s dotfile
collection

## dotfiles

These are my dotfiles, it is mainly intended to be a backup but if you find anything
you like, be my guest: fork and use it!

The setup is based on Zach Holman's "bootstrap" technique.
[read his wonderful post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## install

Run:

```sh
git clone https://github.com/rsrsl/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

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

## thanks

An onormous thanks to [rsrsl](http://github.com/rsrsl) for mentioning this and
for introducing me to vim, and by extension a huge thanks to a lot of people
that I don't have time to mention, but regarding the current project they
should be directed at [Zach Holman](http://github.com/holman) and [Ryan
Bates](http://github.com/ryanb)
