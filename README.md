# Sublime Text Kit

[![Gem Version](https://badge.fury.io/rb/sublime_text_kit.svg)](http://badge.fury.io/rb/sublime_text_kit)
[![Code Climate GPA](https://codeclimate.com/github/bkuhlmann/sublime_text_kit.svg)](https://codeclimate.com/github/bkuhlmann/sublime_text_kit)
[![Code Climate Coverage](https://codeclimate.com/github/bkuhlmann/sublime_text_kit/coverage.svg)](https://codeclimate.com/github/bkuhlmann/sublime_text_kit)
[![Gemnasium Status](https://gemnasium.com/bkuhlmann/sublime_text_kit.svg)](https://gemnasium.com/bkuhlmann/sublime_text_kit)
[![Travis CI Status](https://secure.travis-ci.org/bkuhlmann/sublime_text_kit.svg)](https://travis-ci.org/bkuhlmann/sublime_text_kit)
[![Patreon](https://img.shields.io/badge/patreon-donate-brightgreen.svg)](https://www.patreon.com/bkuhlmann)

A command line interface for managing Sublime Text metadata.

<!-- Tocer[start]: Auto-generated, don't remove. -->

# Table of Contents

- [Features](#features)
- [Screencasts](#screencasts)
- [Requirements](#requirements)
- [Setup](#setup)
  - [Upgrading](#upgrading)
- [Usage](#usage)
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

# Features

- Provides project metadata (i.e. *.sublime-project and *.sublime-workspace files) management for project
  switching via the `CONTROL+COMMAND+P` shortcut.
- Rebuilds project history (Project -> Recent Projects) from existing project files (assumes project
  metadata is in a directory) so one can easily toggle between up-to-date project information via the
  `CONTROL+COMMAND+P` shortcut.

# Screencasts

[![asciicast](https://asciinema.org/a/19858.png)](https://asciinema.org/a/19858)

# Requirements

0. [MRI 2.x.x](https://www.ruby-lang.org).
0. [Sublime Text 2](https://www.sublimetext.com).

# Setup

For a secure install, type the following from the command line (recommended):

    gem cert --add <(curl --location --silent https://www.alchemists.io/gem-public.pem)
    gem install sublime_text_kit --trust-policy MediumSecurity

NOTE: A HighSecurity trust policy would be best but MediumSecurity enables signed gem verification while
allowing the installation of unsigned dependencies since they are beyond the scope of this gem.

For an insecure install, type the following (not recommended):

    gem install sublime_text_kit

You can define settings by creating the following file:

    ~/.sublime/settings.yml

Example:

    ---
    :project_roots:
      - "~/Dropbox/Development/Misc"
      - "~/Dropbox/Development/OSS"
      - "~/Dropbox/Development/Work"
    :metadata_dir: "~/Dropbox/Cache/Sublime"

The project roots define the root level directories where project folders are located. When project metadata (i.e.
*.sublime-project, *.sublime-workspace) is generated, the name of the metadata file will be the same name as that
of the project folder. All project metadata, regardless of root location, is written to the same metadata directory.
If using the example settings shown above and assuming the following directory structure exists...

    ~/Dropbox/Development/Misc/example
    ~/Dropbox/Development/OSS/sublime_text_kit

...the project metadata will be created in the workspace directory as follows:

    ~/Dropbox/Cache/Sublime/example.sublime-project
    ~/Dropbox/Cache/Sublime/example.sublime-workspace
    ~/Dropbox/Cache/Sublime/sublime_text_kit.sublime-project
    ~/Dropbox/Cache/Sublime/sublime_text_kit.sublime-workspace

## Upgrading

For those upgrading from Sublime Text Kit v2.0.0 or earlier, be mindful of the following changes:

0. Ensure you are using Sublime Text 3 (it is currently in Beta but your v2.0.0 license will work).
0. Update the `~/.sublime/settings.yml` file to switch from a `workspace_dir` to a `metadata_dir` instead.
0. Run the following commands to rebuild your project/workspace and session metadata:

        stk -m -R # Destroys and rebuilds your existing project/workspace metadata to Sublime Text 3 format.
        skt -s -r # Rebuilds your session history with project metadata as generated above.

# Usage

From the command line, type: `stk`

    stk -c, [--configure]  # Configure Sublime Text with current settings.
    stk -e, [--edit]       # Edit settings in default editor (assumes $EDITOR environment variable).
    stk -h, [--help=HELP]  # Show this message or get help for a command.
    stk -m, [--metadata]   # Manage project/workspace metadata.
    stk -s, [--session]    # Manage session metadata.
    stk -v, [--version]    # Show version.

For metadata options, type: `stk --metadata`

    -c, [--create], [--no-create]    # Create metadata.
    -D, [--destroy], [--no-destroy]  # Destroy metadata.
    -R, [--rebuild], [--no-rebuild]  # Rebuild metadata.

For session options, type: `stk --session`

    -r, [--rebuild-session], [--no-rebuild-session]  # Rebuild session metadata.

## Workflow

The following demonstrates a default Sublime Text setup:

0. Run: `stk -e` (define Sublime Text Kit settings for project roots and metadata directory).
0. Shutdown Sublime Text (i.e. `CONTROL+Q`).
0. Run: `stk -c` (creates project metadata and rebuilds the session metadata so Sublime Text has a complete project
   history from which to jump through via the `CONTROL+COMMMAND+P` shortcut).
   ).
0. Launch Sublime Text and use the `CONTROL+COMMAND+P` keyboard shortcut to toggle between projects. Notice that
   you can (fuzzy type) project names to jump between them.
0. Breeze through your project workload with ease. :)

## Troubleshooting

- When rebuilding workspaces, ensure Sublime Text is shutdown or changes won't be applied.
- When rebuilding workspaces, ensure workspace_dir (as defined via settings.yml) points to a directory containing
  *.sublime-project and *.sublime-workspace files.

# Tests

To test, run:

    bundle exec rake

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Patch (x.y.Z) - Incremented for small, backwards compatible bug fixes.
- Minor (x.Y.z) - Incremented for new, backwards compatible public API enhancements and/or bug fixes.
- Major (X.y.z) - Incremented for any backwards incompatible public API changes.

# Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By participating in this project
you agree to abide by its terms.

# Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

# License

Copyright (c) 2014 [Alchemists](https://www.alchemists.io).
Read the [LICENSE](LICENSE.md) for details.

# History

Read the [CHANGELOG](CHANGELOG.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

# Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at [Alchemists](https://www.alchemists.io).

