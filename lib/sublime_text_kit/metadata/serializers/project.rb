# frozen_string_literal: true

module SublimeTextKit
  module Metadata
    module Serializers
      # Serializes project metadata.
      class Project
        attr_reader :pathway

        def initialize pathway
          @pathway = pathway
        end

        def to_h
          {
            folders: [
              {path: pathway.project_dir.to_s}
            ]
          }
        end
      end
    end
  end
end
