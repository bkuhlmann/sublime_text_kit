require "multi_json"
require "pathname"

module SublimeTextKit
  class ProjectMetadata
    attr_reader :name, :project_dir, :workspace_dir, :project_file

    def self.create projects_dir, workspace_dir
      projects_dir = File.expand_path projects_dir
      project_paths = ::Pathname.new(projects_dir).children.select {|child| child if child.directory? }
      project_paths.each { |project_dir| new(project_dir, workspace_dir).save }
    end

    def self.delete workspace_dir
      workspace_dir = File.expand_path workspace_dir
      ::Pathname.glob("#{workspace_dir}/*.sublime-*").each(&:delete)
    end

    def initialize project_dir, workspace_dir
      @name = File.basename project_dir
      @project_dir = File.expand_path project_dir
      @workspace_dir = File.expand_path workspace_dir
      @project_file = File.join @workspace_dir, "#{name}.sublime-project"
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
