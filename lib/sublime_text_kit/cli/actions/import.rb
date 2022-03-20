# frozen_string_literal: true

require "auto_injector"

module SublimeTextKit
  module CLI
    module Actions
      Import = AutoInjector[Container]
    end
  end
end
