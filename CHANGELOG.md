# v2.0.0 (2015-01-01)

- Removed Ruby 2.0.0 support.
- Removed Rubinius support.
- Updated spec helper to comment custom config until needed.
- Updated gemspec to use RUBY_GEM_SECURITY env var for gem certs.
- Updated to Thor+ 2.x.x.
- Added Ruby 2.2.0 support.

# v1.1.1 (2014-10-25)

- Fixed bug where projects and workspace directories were not expanded to full path.

# v1.1.0 (2014-10-22)

- Fixed exception when projects or workspace directory doesn't exist when rebuilding project information.
- Fixed exception thrown when workspace directory doesn't exist when trying to delete project information.
- Updated Multi-JSON gem.
- Updated Thor+ gem.

# v1.0.0 (2014-09-21)

- Updated to Ruby 2.1.3.
- Updated gemspec to add security keys unless in a CI environment.
- Updated Code Climate to run only if environment variable is present.
- Added author and email arrays to gemspec.
- Added the Guard Terminal Notifier gem.
- Added project metadata creation support.
- Added project metadata destruction support.
- Refactored RSpec setup and support files.
- Refactored workspaces_path to workspace_dir (make sure to update your settings.yml).

# v0.4.0 (2014-07-06)

- Added Code Climate test coverage support.
- Updated to Ruby 2.1.2.
- Updated gem-public.pem for gem install certificate chain.

# v0.3.0 (2014-04-16)

- Fixed bug where workspace would not be expanded to absolute path properly.
- Updated to MRI 2.1.1.
- Updated to Rubinius 2.x.x.
- Updated README with --trust-policy for secure install of gem.
- Updated RSpec helper to disable GC for all specs in order to improve performance.
- Updated output of workspaces path to be the absolute path.
- Added Gemnasium support.
- Added Coveralls support.
- Added Rails 4.1.x support.
- Added multi_json support.

# v0.2.0 (2014-02-16)

- Added JRuby and Rubinius VM support.

# v0.1.0 (2014-01-27)

- Initial version.
