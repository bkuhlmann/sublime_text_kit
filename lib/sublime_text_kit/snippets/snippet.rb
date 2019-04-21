# frozen_string_literal: true

require "rexml/document"

module SublimeTextKit
  module Snippets
    class Snippet
      ELEMENT_TRANSLATIONS = {
        "content" => :content,
        "tabTrigger" => :trigger,
        "description" => :description,
        "scope" => :scope
      }.freeze

      ALLOWED_METHODS = ELEMENT_TRANSLATIONS.values.freeze

      def initialize document
        @document = document
        assign_elements
      end

      private

      attr_reader :document,
                  :content_element,
                  :trigger_element,
                  :description_element,
                  :scope_element

      def assign_elements
        root_element.elements.each do |element|
          name = element.name

          fail StandardError, "Unknown element: #{element}." unless ELEMENT_TRANSLATIONS.key? name

          instance_variable_set "@#{ELEMENT_TRANSLATIONS[name]}_element", element
        end
      end

      def root_element
        document.root || REXML::Element.new
      end

      def method_missing name, *arguments, &block
        return super unless respond_to_missing? name

        String((__send__("#{name}_element") || REXML::Element.new).text)
      end

      # :reek:BooleanParameter
      def respond_to_missing? name, include_private = false
        ALLOWED_METHODS.include?(name) || super
      end
    end
  end
end
