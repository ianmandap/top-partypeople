# frozen_string_literal: true

module Tabs
  class BodyComponent < ViewComponent::Base
    def initialize(header_id:)
      @header_id = header_id
    end
  end
end
