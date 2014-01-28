# Overview

[![Gem Version](https://badge.fury.io/rb/sublime_text_kit.png)](http://badge.fury.io/rb/sublime_text_kit)
[![Code Climate GPA](https://codeclimate.com/github/bkuhlmann/sublime_text_kit.png)](https://codeclimate.com/github/bkuhlmann/sublime_text_kit)
[![Travis CI Status](https://secure.travis-ci.org/bkuhlmann/sublime_text_kit.png)](http://travis-ci.org/bkuhlmann/sublime_text_kit)

Provides a collection of utilities that aids in Sublime Text managment. The utilities are fairly sparse at the
moment but the idea is that this will grow over time.

# Features

* Rebuilds recent workspace history (via Project -> Recent Projects) from existing project files (assumes
  workspaces are in a single directory) so one can easily toggle between up-to-date project information via
  the COMMAND+CONTROL+P shortcut.

# Requirements

0. [Ruby 2.x.x](http://www.ruby-lang.org).
0. [Sublime Text 2](http://www.sublimetext.com).

# Setup

For a secure install, type the following from the command line (recommended):

    gem cert --add <(curl -Ls http://www.redalchemist.com/gem-public.pem)
    gem install sublime_text_kit -P HighSecurity

...or, for an insecure install, type the following (not recommended):

    gem install sublime_text_kit

You can define settings by creating the following file:

    ~/.sublime/settings.yml

Example:

    ---
    :workspaces_path: ~/Dropbox/Cache/Sublime

# Usage

From the command line, type: stk

    stk -e, [--edit]       # Edit settings in default editor (assumes $EDITOR environment variable).
    stk -h, [--help=HELP]  # Show this message or get help for a command.
    stk -s, [--session]    # Manage session data.
    stk -v, [--version]    # Show version.

For settion options, type: stk help --session

    -r, [--rebuild-recent-workspaces]  # Rebuild recent workspaces.

# Troubleshooting

* When rebuilding workspaces, ensure workspaces_path (as defined via settings.yml) points to a directory containing
  both *.sublime-project and *.sublime-workspace files.

# Tests

To test, do the following:

0. cd to the gem root.
0. bundle install
0. bundle exec rspec spec

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

* Patch (x.y.Z) - Incremented for small, backwards compatible bug fixes.
* Minor (x.Y.z) - Incremented for new, backwards compatible public API enhancements and/or bug fixes.
* Major (X.y.z) - Incremented for any backwards incompatible public API changes.

# Contributions

Read CONTRIBUTING for details.

# Credits

Developed by [Brooke Kuhlmann](http://www.redalchemist.com) at [Red Alchemist](http://www.redalchemist.com).

# License

Copyright (c) 2014 [Red Alchemist](http://www.redalchemist.com).
Read the LICENSE for details.

# History

Read the CHANGELOG for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).
