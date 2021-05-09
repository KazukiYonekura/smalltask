RSpec.describe "UsersNews", type: :request do
  describe "GET /users_news" do
    it "is invalid signup information" do
      get new_user_path
      expect do
        post users_path, params: {
          user: {
            name: "",
            email: "user@invalid",
            password: "foo",
            password_confirmation: "bar",
          },
        }
      end.not_to change(User, :count)
    end

    it "is valid signup information" do
      get new_user_path
      expect do
        post users_path, params: {
          user: {
            name: "Example User",
            email: "user@example.com",
            password: "password",
            password_confirmation: "password",
          },
        }
      end.to change(User, :count).by(1)
    end
  end
end
