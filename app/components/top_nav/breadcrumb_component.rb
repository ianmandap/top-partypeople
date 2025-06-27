# frozen_string_literal: true

module TopNav
  class BreadcrumbComponent < ViewComponent::Base
    def initialize(name:, path:)
      @name = name
      @path = path
    end
  end
end
