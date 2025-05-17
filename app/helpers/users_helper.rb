module UsersHelper
  def generate_attendees_modal_id
    "attendees-modal--#{SecureRandom.hex(4)}"
  end
end
