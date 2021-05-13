RSpec.describe "UsersNews", type: :request do
  describe "index test" do
    before do
      get signup_path
    end

    it 'returns a 200 response' do
      expect(response).to be_successful
      expect(response).to have_http_status 200
    end
  end
end
