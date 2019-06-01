<p align="center">
  <img src="sublime_text_kit.png" alt="Sublime Text Kit Icon"/>
</p>

# Sublime Text Kit

[![Gem Version](https://badge.fury.io/rb/sublime_text_kit.svg)](http://badge.fury.io/rb/sublime_text_kit)
[![Code Climate Maintainability](https://api.codeclimate.com/v1/badges/ad83a2a96bf791ff47b7/maintainability)](https://codeclimate.com/github/bkuhlmann/sublime_text_kit/maintainability)
[![Code Climate Test Coverage](https://api.codeclimate.com/v1/badges/ad83a2a96bf791ff47b7/test_coverage)](https://codeclimate.com/github/bkuhlmann/sublime_text_kit/test_coverage)
[![Circle CI Status](https://circleci.com/gh/bkuhlmann/sublime_text_kit.svg?style=svg)](https://circleci.com/gh/bkuhlmann/sublime_text_kit)

A command line interface for managing Sublime Text metadata.

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [Features](#features)
  - [Screencasts](#screencasts)
  - [Requirements](#requirements)
  - [Setup](#setup)
  - [Usage](#usage)
    - [Command Line Interface (CLI)](#command-line-interface-cli)
    - [Customization](#customization)
    - [Workflow](#workflow)
    - [Troubleshooting](#troubleshooting)
  - [Tests](#tests)
  - [Versioning](#versioning)
  - [Code of Conduct](#code-of-conduct)
  - [Contributions](#contributions)
  - [License](#license)
  - [History](#history)
  - [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

## Features

- Provides project metadata (i.e. *.sublime-project and *.sublime-workspace files) management for
  project switching via the `CONTROL+COMMAND+P` shortcut.
- Rebuilds project history (Project -> Recent Projects) from existing project files (assumes project
  metadata is in a directory) so one can easily toggle between up-to-date project information via
  the `CONTROL+COMMAND+P` shortcut.

## Screencasts

[![asciicast](https://asciinema.org/a/92707.png)](https://asciinema.org/a/92707)

## Requirements

1. [Ruby 2.6.x](https://www.ruby-lang.org).
1. [Sublime Text 3](https://www.sublimetext.com).

## Setup

Type the following to install:

    gem install sublime_text_kit

## Usage

### Command Line Interface (CLI)

From the command line, type: `sublime_text_kit`

    sublime_text_kit -c, [--config]        # Manage gem configuration.
    sublime_text_kit -h, [--help=COMMAND]  # Show this message or get help for a command.
    sublime_text_kit -m, [--metadata]      # Manage project/workspace metadata.
    sublime_text_kit -s, [--session]       # Manage session metadata.
    sublime_text_kit -u, [--update]        # Update Sublime Text with current settings.
    sublime_text_kit -v, [--version]       # Show gem version.

For configuration options, type: `sublime_text_kit --help --config`

    -e, [--edit], [--no-edit]  # Edit gem configuration.
    -i, [--info], [--no-info]  # Print gem configuration.

For metadata options, type: `sublime_text_kit --help --metadata`

    -c, [--create], [--no-create]    # Create metadata.
    -D, [--destroy], [--no-destroy]  # Destroy metadata.
    -R, [--rebuild], [--no-rebuild]  # Rebuild metadata.

For session options, type: `sublime_text_kit --help --session`

    -R, [--rebuild], [--no-rebuild]  # Rebuild session metadata.

### Customization

This gem can be configured via a global configuration:

    ~/.config/sublime_text_kit/configuration.yml

It can also be configured via [XDG](https://github.com/bkuhlmann/xdg) environment variables.

An example configuration could be:

    :project_roots:
      - "~/Dropbox/Development/Misc"
      - "~/Dropbox/Development/OSS"
      - "~/Dropbox/Development/Work"
    :metadata_dir: "~/Dropbox/Cache/Sublime"

Feel free to take this configuration, modify, and save as your own custom `configuration.yml`.

The project roots define the root level directories where project folders are located. When project
metadata (i.e. `*.sublime-project`, `*.sublime-workspace`) is generated, the name of the metadata
file will be the same name as that of the project folder. All project metadata, regardless of root
location, is written to the same metadata directory. If using the example settings shown above and
assuming the following directory structure exists...

    ~/Dropbox/Development/Misc/example
    ~/Dropbox/Development/OSS/sublime_text_kit

...the project metadata will be created in the workspace directory as follows:

    ~/Dropbox/Cache/Sublime/example.sublime-project
    ~/Dropbox/Cache/Sublime/example.sublime-workspace
    ~/Dropbox/Cache/Sublime/sublime_text_kit.sublime-project
    ~/Dropbox/Cache/Sublime/sublime_text_kit.sublime-workspace

### Workflow

The following demonstrates a default Sublime Text setup:

1. Run: `sublime_text_kit --config --edit` (define Sublime Text Kit settings for project roots and
   metadata directory).
1. Shutdown Sublime Text (i.e. `CONTROL+Q`).
1. Run: `sublime_text_kit --metadata --create` (creates project metadata and rebuilds the session
   metadata so Sublime Text has a complete project history from which to jump through via the
   `CONTROL+COMMMAND+P` shortcut).
1. Launch Sublime Text and use the `CONTROL+COMMAND+P` keyboard shortcut to toggle between projects.
   Notice that you can (fuzzy type) project names to jump between them.
1. Breeze through your project workload with ease. :)

### Troubleshooting

- When rebuilding workspaces, ensure Sublime Text is shutdown or changes won't be applied.
- When rebuilding workspaces, ensure workspace_dir (as defined via settings.yml) points to a
  directory containing `*.sublime-project` and `*.sublime-workspace` files.

## Tests

To test, run:

    bundle exec rake

## Versioning

Read [Semantic Versioning](https://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

## Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

## Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

## License

Copyright 2014 [Alchemists](https://www.alchemists.io).
Read [LICENSE](LICENSE.md) for details.

## History

Read [CHANGES](CHANGES.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

## Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at
[Alchemists](https://www.alchemists.io).

