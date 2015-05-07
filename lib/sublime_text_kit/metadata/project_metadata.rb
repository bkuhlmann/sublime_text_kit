require "multi_json"
require "pathname"

module SublimeTextKit
  module Metadata
    class Project
      attr_reader :name, :project_dir, :metadata_dir, :project_file

      def self.create projects_dir, metadata_dir
        projects_dir = File.expand_path projects_dir
        metadata_dir = File.expand_path metadata_dir

        return unless valid_dir?(projects_dir, "Projects")
        return unless valid_dir?(metadata_dir, "Metadata")

        project_paths = ::Pathname.new(projects_dir).children.select {|child| child if child.directory? }
        project_paths.each { |project_dir| new(project_dir, metadata_dir).save }
      end

      def self.delete metadata_dir
        metadata_dir = File.expand_path metadata_dir

        return unless valid_dir?(metadata_dir, "Metadata")

        ::Pathname.glob("#{metadata_dir}/*.sublime-*").each(&:delete)
      end

      def initialize project_dir, metadata_dir
        @name = File.basename project_dir
        @project_dir = File.expand_path project_dir
        @metadata_dir = File.expand_path metadata_dir
        @project_file = File.join @metadata_dir, "#{name}.sublime-project"
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

      private

      def self.valid_dir? dir, label
        if File.exist?(dir)
          true
        else
          puts "#{label} directory doesn't exist: #{dir}."
          false
        end
      end
    end
  end
end
