RSpec.describe "UsersNews", type: :request do
  describe "index test" do
    before do
      get users_path
    end

    it '200が返ってくる' do
      expect(response).to be_successful
      expect(response).to have_http_status 200
    end
  end
end
