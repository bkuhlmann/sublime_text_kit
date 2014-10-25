# Overview

[![Gem Version](https://badge.fury.io/rb/sublime_text_kit.png)](http://badge.fury.io/rb/sublime_text_kit)
[![Code Climate GPA](https://codeclimate.com/github/bkuhlmann/sublime_text_kit.png)](https://codeclimate.com/github/bkuhlmann/sublime_text_kit)
[![Code Climate Coverage](https://codeclimate.com/github/bkuhlmann/sublime_text_kit/coverage.png)](https://codeclimate.com/github/bkuhlmann/sublime_text_kit)
[![Gemnasium Status](https://gemnasium.com/bkuhlmann/sublime_text_kit.png)](https://gemnasium.com/bkuhlmann/sublime_text_kit)
[![Travis CI Status](https://secure.travis-ci.org/bkuhlmann/sublime_text_kit.png)](http://travis-ci.org/bkuhlmann/sublime_text_kit)
[![Gittip](http://img.shields.io/gittip/bkuhlmann.svg)](https://www.gittip.com/bkuhlmann)

Provides a collection of utilities that aid in Sublime Text management.

# Features

- Creates project metadata (i.e. *.sublime-project files) for easy project switching via the `COMMAND+CONTROL+P`
  shortcut.
- Destroys project metadata (i.e. *.sublime-project and *.sublime-workspace files).
- Rebuilds recent workspace history (via Project -> Recent Projects) from existing project files (assumes workspaces are
  in a single directory) so one can easily toggle between up-to-date project information via the `COMMAND+CONTROL+P`
  shortcut.

# Requirements

0. Any of the following Ruby VMs:
    - [MRI 2.x.x](http://www.ruby-lang.org)
    - [JRuby 1.x.x](http://jruby.org)
    - [Rubinius 2.x.x](http://rubini.us)
0. [Sublime Text 2](http://www.sublimetext.com).

# Setup

For a secure install, type the following from the command line (recommended):

    gem cert --add <(curl -Ls https://www.alchemists.io/gem-public.pem)
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
    :workspace_dir: "~/Dropbox/Cache/Sublime"

The project roots are the root level directories to where project folders are located. When project metadata (i.e.
*.sublime-project) is generated, the name of the metadata file will be the same name as that of the project folder. All
project metadata, regardless of root location, is written to the same workspace directory. If using the example settings
shown above and assuming the following directory structure exists...

    ~/Dropbox/Development/Misc/example
    ~/Dropbox/Development/OSS/sublime_text_kit

...the project metadata will be created in the workspace directory as follows:

    ~/Dropbox/Cache/Sublime/example.sublime-project
    ~/Dropbox/Cache/Sublime/sublime_text_kit.sublime-project

# Usage

From the command line, type: stk

    stk -e, [--edit]       # Edit settings in default editor (assumes $EDITOR environment variable).
    stk -h, [--help=HELP]  # Show this message or get help for a command.
    stk -p, [--project]    # Manage project metadata.
    stk -s, [--session]    # Manage session data.
    stk -v, [--version]    # Show version.

For project options, type: stk --project

    -c, [--create], [--no-create]    # Create project metadata.
    -D, [--destroy], [--no-destroy]  # Destroy all project metadata.

For session options, type: stk --session

    -r, [--rebuild-recent-workspaces]  # Rebuild recent workspaces.

# Tests

To test, run:

    bundle exec rspec spec

# Workflow

The following demonstrates a common workflow that makes you more productive with Sublime Text:

0. Run: `stk -e` (define Sublime Text Kit settings for project roots and workspace directory).
0. Shutdown Sublime Text (i.e. `CONTROL+Q`).
0. Run: `stk -p -D` (optional -- start with a clean slate. WARNING: This deletes all project metadata in the workspace
   dir).
0. Run: `stk -p -c` (creates project metadata so Sublime Text knows where to source the project from).
0. Run: `stk -s -r` (rebuilds Sublime Text recent workspace metadata based on the project metadata created in Step #4).
0. Launch Sublime Text
0. Type: `COMMAND+CONTROL+P` to toggle between projects. Notice that you can easily (fuzzy type) project names to jump
   between them.
0. Breeze through your project workload with ease. :)

# Troubleshooting

- When rebuilding workspaces, ensure Sublime Text is shutdown or changes won't be applied.
- When rebuilding workspaces, ensure workspace_dir (as defined via settings.yml) points to a directory containing
  *.sublime-project files.

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Patch (x.y.Z) - Incremented for small, backwards compatible bug fixes.
- Minor (x.Y.z) - Incremented for new, backwards compatible public API enhancements and/or bug fixes.
- Major (X.y.z) - Incremented for any backwards incompatible public API changes.

# Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

# Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at [Alchemists](https://www.alchemists.io).

# License

Copyright (c) 2014 [Alchemists](https://www.alchemists.io).
Read the [LICENSE](LICENSE.md) for details.

# History

Read the [CHANGELOG](CHANGELOG.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).
