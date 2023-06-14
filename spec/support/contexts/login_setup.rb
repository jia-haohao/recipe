RSpec.shared_context "admin_login_setup" do
  before do
    visit new_user_session_path
    fill_in 'user_email', with: 'second@gmail.com'
    fill_in 'user_password', with: 'password2'
    click_button 'ログイン'
  end
end
  
RSpec.shared_context "login_setup" do
  before do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'ログイン'
  end
end