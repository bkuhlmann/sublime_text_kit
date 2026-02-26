# frozen_string_literal: true

module SublimeTextKit
  module Metadata
    # Defines metadata pathways.
    Pathway = Struct.new :project_dir, :metadata_dir do
      using Refinements::Pathname

      def initialize(**)
        super
        each_pair { |key, value| self[key] = Pathname(value).expand_path }
      end

      def project_name = project_dir.basename

      def metadata_file(extension) = metadata_dir.join("#{project_name}.#{extension}")
    end
  end
end
