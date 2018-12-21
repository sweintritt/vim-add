vim-add
=========

Manages vim plugins. Plugins can be installed, removed and updated (using git).
Plugin urls can be added to a configuration file in the home folder, which will
be created if not present.

# Build

To create a Debian package, create a build folder

    $ mkdir cmake-build
    $ cd cmake-build

Create a Makefile with cmake and build the package

    $ cmake ..
    $ make package

# Installation

The easiest way is to build the package and install it. So far I only checked the
installation on Ubuntu 16.04, 18.04 and Debian 9 (all 64-Bit).

Or you can just put the script anywhere in your home folder, e.g. `~/bin`. The directory must be in
`PATH` or an alias must be set, that you can simply call the script. This is
required by the bash completion.

Copy the bash completion scrpt into `/ets/bash_completion.d`.

# Commands

If the script is started without a command it will print a small help page showing the
available commands.

```
vim-add <command>

   add <url>
       Add the given URL to the config file.

   delete <name>
       Remove the given plugin and delete it from the config file

   help
       Prints this usage message

   install <name>|all
       Install the plugin given by name, or all.

   remove <name>|all
       Remove the given plugin, or all.

   status <plugin>
       Show the status of the given plugins, or all if no name is given.
       Possible states are: INSTALLED and NOT-INSTALLED

   update <name>|all
       Update the given plugin, or all.

   version
       Version of this script.
```

## Add

Add a new plugin to the configuration file by providing a URL to the git
repository.

    $ vim-add add https://github.com/vim-airline/vim-airline

The last part of the URL is used as plugin name.

## Delete

Delete a plugin from the configuration file.

    $ vim-add delete https://github.com/vim-airline/vim-airline

If the plugin is installed it is removed first.

## Help

The help command displays the help page.

## Install

To install a plugin use the install command and the name of the plugin you want to install.
The name of the plugin must be equal to the names displayed in the status page and are the
last part of the url. For `https://github.com/vim-airline/vim-airline` the name is `vim-airline`.

    $ ./vim-add install vim-airline
    --- Installing vim-airline
    --- Installed vim-airline

This will clone the given repository into `~/.vim/bundle`. Pathogen will load it once it is present.
To add all plugins from the properties file use `all` with `install`.

You can just comment out plugins you don't need in the properties file. That way *all* will always
address all the plugins you need. Setting up your vim can be done by simply running

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
name of the plugin exists inside `~/.vim/bundle`. It is also possible to give the status command a
plugin name

    $ ./vim-add status vim-airline
    --- Plugin vim-airline is installed

## Update

The `update` command allows to update a specific plugin or all plugins

    $ ./vim-add update all

This will call `git pull` in all subdirectories of `~/.vim/bundle`.

## Version

Prints the scripts version.

    $ vim-add version
    vim-add version 2.0.0
