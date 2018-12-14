vim-add
=========

Manages vim plugins. Plugins can be installed, removed and updated (with git).
Plugin urls must be added to the properties files to be managed by the script.

# Configuration

The `vim-add.properties` contains urls of git repositories of vim plugins.

```bash
# Just add plugins by adding the URL in a new line
# Lines starting with # are comments
# Comments behind URLs do not work

# Pathogen is required and must be the first in the list
https://github.com/tpope/vim-pathogen

# Add your plugins below this line
https://github.com/davidhalter/jedi-vim
https://github.com/justmao945/vim-clang
https://github.com/kien/ctrlp.vim
https://github.com/fatih/vim-go
https://github.com/flazz/vim-colorschemes
https://github.com/powerline/fonts
https://github.com/scrooloose/nerdtree
https://github.com/scrooloose/nerdcommenter
https://github.com/tomasr/molokai
https://github.com/tpope/vim-fugitive
https://github.com/Valloric/YouCompleteMe
https://github.com/vim-airline/vim-airline
https://github.com/vim-airline/vim-airline-themes
https://github.com/vim-syntastic/syntastic
```

I use pathogen to load vim plugins. The script will install all plugins in
`$HOME/.vim/bundle`. You can change the target location in the script itself
by changing the value of `BUNDLE_DIR`

    BUNDLE_DIR=$HOME/.vim/bundle

# Installation

Put the script anywhere in your home folder. The properties file must be in
the same path as the script.

# Commands

If the script is started without a command it will print a small help page showing the
available commands.

    $ ./vim-add
    --- No command given.

    vim-add <command>

       help
           Prints this usage message.

       install <name>|all
           Install the plugin given by name, or all.

       remove <name>|all
           Remove the given plugin, or all.

       status <plugin>
           Show the status of the given plugins, or all if no name is given.
           Possible states are: 'installed' and 'not installed'.

       update <name>|all
           Update the given plugin, or all.

       version
           Version of this script.

## Help

The help command displays the help page.

## Install

To install a plugin use the install command and the name of the plugin you want to install.
The name of the plugin must be equal to the names displayed in the status page and are the
last part of the url. For `https://github.com/vim-airline/vim-airline` the name is `vim-airline`.

    $ ./vim-add install vim-airline
    --- Installing vim-airline
    Cloning into 'vim-airline'...
    remote: Counting objects: 9661, done.
    remote: Compressing objects: 100% (114/114), done.
    Receiving objects: 100% (9661/9661), 2.28 MiB | 1.39 MiB/s, done.
    remote: Total 9661 (delta 69), reused 112 (delta 63), pack-reused 9476
    Resolving deltas: 100% (4706/4706), done.
    Checking connectivity... done.
    --- Installed vim-airline

This will clone the given repository into `BUNDLE_DIR`. Pathogen will load it once it is present.
To add all plugins from the properties file use `all` with `install`.

You can just comment out plugins you don't need in the properties file. That way *all* will always
adress all the plugins you need. Setting up your vim can be done by simply running

    $ ./vim-add install all

## Remove

To remove a plugin run `remove` with the name of the plugin

    $ ./vim-add remove vim-airline
    --- Removing vim-airline
    --- Removed vim-airline

or `all` for all plugins in the properties file

    $ ./vim-add remove all

## Status

To see the status of all plugins just type

    $ ./vim-add status
    --- Status of plugins:

      vim-pathogen       - installed
      vim-airline        - installed
      vim-airline-themes - installed
      jedi-vim           - not installed
      nerdtree           - installed
      fonts              - not installed
      syntastic          - not installed
      vim-clang          - not installed
      YouCompleteMe      - not installed
      ctrlp.vim          - not installed
      molokai            - not installed
      nerdcommenter      - not installed
      vim-go             - not installed
      vim-fugitive       - not installed

this will check if the plugin is installed or not. It is simply tested if a subdirectory with the
name of the plugin exists inside `BUNDLE_DIR`. It is also possible to give the status command a
plugin name

    $ ./vim-add status vim-pathogen
    --- Plugin vim-pathogen is installed

## Update

The `update` command allows to update a specific plugin or all plugins

    $ ./vim-add update all

This will call `git pull` in all subdirectories of `BUNDLE_DIR`.

## Version

Prints the scripts version.

    $ ./vim-add version
    vim-add version 1.0.0
