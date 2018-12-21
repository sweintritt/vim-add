# Changelog

## [Unreleased]

## [2.0.0] - 2018-12-21

### Added

* CMake script to create Debian package

### Changed

* vim-add now uses a config file in the users home folder, which is created if not
  present and a list of initial plugins is added.
* Pathogen is no longer contained in the config file, but in the script itself.

## [1.2.0] - 2018-12-18

### Added

* Checks if the given URL is valid
* Bash completion script

## [1.1.1] - 2018-12-18

### Added

* vim-commentary and vim-surround to the plugin list.

### Fixed

* Matching of plugin names. Full name must be matched. For example `vim-add install pathogen`
  will no longer install *vim-pathogen* plugin.

## [1.1.0] - 2018-12-15

### Added

* Commands to add/remove plugins URLs from the config file

## [1.0.0] - 2018-12-14

* Initial version of vim-add
