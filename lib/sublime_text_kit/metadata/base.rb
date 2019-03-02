# frozen_string_literal: true

require "json"
require "pathname"

module SublimeTextKit
  module Metadata
    # Abstract class for processing metadata.
    class Base
      attr_reader :name, :project_dir, :metadata_dir, :metadata_file

      def self.create projects_dir, metadata_dir
        instance = new projects_dir, metadata_dir
        return unless valid_dir? instance.project_dir, "Projects"
        return unless valid_dir? instance.metadata_dir, "Metadata"

        project_paths = ::Pathname.new(instance.project_dir).children.select(&:directory?)
        project_paths.each { |project_dir| new(project_dir, metadata_dir).save }
      end

      def self.delete metadata_dir
        instance = new "", metadata_dir
        return unless valid_dir? instance.metadata_dir, "Metadata"

        ::Pathname.glob("#{instance.metadata_dir}/*.#{instance.file_extension}").each(&:delete)
      end

      def initialize project_dir, metadata_dir
        @name = File.basename project_dir
        @project_dir = File.expand_path project_dir
        @metadata_dir = File.expand_path metadata_dir
        @metadata_file = File.join @metadata_dir, "#{name}.#{file_extension}"
      end

      def file_extension
        "sublime-unknown"
      end

      def to_h
        {}
      end

      def save
        return if File.exist? metadata_file

        File.open(metadata_file, "w") { |file| file.write JSON.dump(to_h) }
      end

      def self.valid_dir? dir, label
        if File.exist? dir
          true
        else
          puts "#{label} directory doesn't exist: #{dir}."
          false
        end
      end
      private_class_method :valid_dir?
    end
  end
end
