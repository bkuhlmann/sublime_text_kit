# frozen_string_literal: true

module SublimeTextKit
  module Metadata
    module Serializers
      # Serializes workspace metadata.
      class Workspace
        attr_reader :pathway

        def initialize pathway
          @pathway = pathway
        end

        def to_h
          {
            expanded_folders: [pathway.project_dir.to_s],
            select_project: {
              selected_items: [
                [pathway.project_name.to_s, pathway.metadata_file("sublime-project").to_s]
              ]
            }
          }
        end
      end
    end
  end
end
