RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "GET /users/:id" do
    it "does not go to users/1 because of having not log in" do
      get user_path(user.id)
      follow_redirect!
      expect(request.fullpath).to eq login_path
    end

    it "valid user image" do
      log_in_as(user)
      expect(is_logged_in?).to be_truthy
      get user_path(user.id)
      expect(request.fullpath).to eq user_path(user.id)
    end
  end
end
