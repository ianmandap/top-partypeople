module LoginHelper
  def login(user)
    post session_path, params: { email_address: user.email_address, password: user.password }
  end

  def selenium_login(user)
    visit new_session_path
    find('#email_address').set(user.email_address)
    find('#password').set(user.password)
    find('#login-button-new-session').click
  end
end
