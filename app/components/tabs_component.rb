# frozen_string_literal: true

class TabsComponent < ViewComponent::Base
  renders_many :headers, Tabs::HeaderComponent
  renders_many :bodies, Tabs::BodyComponent

  def initialize(id:)
    @id = id
  end
end
