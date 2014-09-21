require "multi_json"
require "pathname"

module SublimeTextKit
  class ProjectMetadata
    attr_reader :name, :project_dir, :workspaces_path, :project_file

    def self.create projects_dir, workspaces_path
      projects_dir = File.expand_path projects_dir
      project_paths = ::Pathname.new(projects_dir).children.select {|child| child if child.directory? }
      project_paths.each { |project_dir| new(project_dir, workspaces_path).save }
    end

    def initialize project_dir, workspaces_path
      @name = File.basename project_dir
      @project_dir = File.expand_path project_dir
      @workspaces_path = File.expand_path workspaces_path
      @project_file = File.join @workspaces_path, "#{name}.sublime-project"
    end

    def to_h
      {
        folders: [
          {path: "#{project_dir}"}
        ]
      }
    end

    def save
      unless File.exist? project_file
        File.open(project_file, 'w') { |file| file.write MultiJson.dump(to_h, pretty: true) }
      end
    end
  end
end
