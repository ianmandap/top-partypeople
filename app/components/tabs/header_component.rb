# frozen_string_literal: true

module Tabs
  class HeaderComponent < ViewComponent::Base
    def initialize(header_id:, header_title:)
      @header_id = header_id
      @header_title = header_title
    end
  end
end
