# frozen_string_literal: true

class AvatarComponent < ViewComponent::Base
  # https://dev.to/admitkard/auto-generate-avatar-colors-randomly-138j
  # https://gist.github.com/Yardboy/1f28d12b79bc68ffba04b1e2c4dfce28

  DEFAULT_COLOR = [ 240, 2, 85 ].freeze
  HRANGE = [ 0, 360 ].freeze
  SRANGE = [ 40, 60 ].freeze
  LRANGE = [ 40, 60 ].freeze

  attr_reader :user, :size

  delegate :email_address, :display_name, to: :user, allow_nil: true

  def initialize(user:, size: "2.5rem", data_hash: {}, override_color: nil)
    @user = user
    @size = size
    @data_hash = data_hash
    @override_color = override_color
  end

  def initials
    return user unless user.respond_to?("display_name")

    # use POSIX bracket expression to capture alphabetic char and limit to max 2 initials
    display_name.scan(/([[:alpha:]])[[:alpha:]]*/).flatten.join.upcase[0..1]
  end

  def width
    # tailwind interpolation does not work so manually set size via style
    @size
  end

  def color
    return @override_color if @override_color

    "hsl(#{hsl[0]}, #{hsl[1]}%, #{hsl[2]}%)"
  end

  def hsl
    @hsl ||= user.nil? ? DEFAULT_COLOR : hashed_color
  end

  def hashed_color
    [
      normalize(hash: hash_of_string, range: HRANGE),
      normalize(hash: hash_of_string, range: SRANGE),
      normalize(hash: hash_of_string, range: LRANGE)
    ]
  end

  def hash_of_string
    @hash_of_string ||= email_address.chars.inject(0) do |hash, letter|
      letter.ord + ((hash << 5) - hash)
    end
  end

  def normalize(hash:, range:)
    ((hash % (range.last - range.first)) + range.first).floor
  end
end
