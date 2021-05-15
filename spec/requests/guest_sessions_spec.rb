RSpec.describe "GuestSessions", type: :request do
  it 'valid login gestuser' do
    get login_path
    post guest_sessions_path
    user = assigns(:user)
    expect(is_logged_in?).to be_truthy
    expect(flash[:success]).to be_truthy
    follow_redirect!
    expect(request.fullpath).to eq user_path(user.id)
  end
end
