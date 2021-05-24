RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) }

  describe "GET /show" do
    it "returns http success" do
      log_in_as(user)
      get profile_path(user.id)
      expect(response).to have_http_status(:success)
    end
  end
end
