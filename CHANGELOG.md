# v3.2.0 (2015-12-02)

- Fixed README URLs to use HTTPS schemes where possible.
- Fixed README test command instructions.
- Added Gemsmith development support.
- Added Identity module description.
- Added Patreon badge to README.
- Added Rubocop support.
- Added [pry-state](https://github.com/SudhagarS/pry-state) support.
- Added gem configuration file name to identity.
- Added gem label to CLI version description.
- Added package name to CLI.
- Added project name to README.
- Added table of contents to README.
- Updated --edit option to include gem name in description.
- Updated Code Climate to run when CI ENV is set.
- Updated Code of Conduct 1.3.0.
- Updated README with Tocer generated Table of Contents.
- Updated RSpec support kit with new Gemsmith changes.
- Updated to Ruby 2.2.3.
- Updated README with SVG icons.
- Updated to Travis CI Docker container builds.
- Removed GitTip badge from README.
- Removed unnecessary exclusions from .gitignore.

# v3.1.0 (2015-07-05)

- Removed JRuby support (no longer officially supported).
- Fixed secure gem installs (new cert has 10 year lifespan).
- Added CLI process title support.

# v3.0.0 (2015-05-10)

- Removed CLI --project support (replaced with --metadata)
- Removed ProjectMetadata#workspace_dir (changed to #metadata_dir instead).
- Removed the workspace_dir YAML settings (replaced with metadata_dir).
- Updated to Ruby 2.2.2.
- Updated session path to use Sublime Text 3 file structure.
- Added Sublime Text 3 support (removed Sublime Text 2 support).
- Added `stk --configure` option.
- Added `stk --metadata --rebuild` option.
- Added code of conduct documentation.
- Added workspace metadata generation.

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
