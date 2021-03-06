RSpec.describe "UsersEdits", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }

  def patch_invalid_information
    patch user_path(user), params: {
      user: {
        name: "",
        email: "foo@invalid",
        password: "foo",
        password_confirmation: "bar",
      },
    }
  end

  def patch_valid_information
    patch user_path(user), params: {
      user: {
        name: "Example User",
        email: "user@example.com",
        password: "password",
        password_confirmation: "password",
      },
    }
  end

  describe "GET /users/:id/edit" do
    context "invalid" do
      it "is invalid because of having not log in" do
        get edit_user_path(user.id)
        follow_redirect!
        expect(request.fullpath).to eq login_path
      end

      it "is invalid because of having log in as wrong user" do
        log_in_as(other_user)
        get edit_user_path(user.id)
        follow_redirect!
        expect(request.fullpath).to eq user_path(other_user.id)
      end

      it "is invalid edit informaiton" do
        log_in_as(user)
        expect(is_logged_in?).to be_truthy
        get edit_user_path(user)
        expect(request.fullpath).to eq edit_user_path(user.id)
        patch_invalid_information
        expect(flash[:danger]).to be_truthy
        expect(request.fullpath).to eq user_path(user.id)
      end

      it "does not redirect update because of having log in as wrong user" do
        log_in_as(other_user)
        get edit_user_path(user.id)
        patch_valid_information
        follow_redirect!
        expect(request.fullpath).to eq user_path(other_user.id)
      end
    end

    context "valid" do
      it "is valid edit information" do
        log_in_as(user)
        get edit_user_path(user)
        patch_valid_information
        expect(flash[:success]).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq edit_user_path(user.id)
      end

      it "goes to previous link because they had logged in as right user" do
        get edit_user_path(user)
        follow_redirect!
        expect(request.fullpath).to eq login_path
        log_in_as(user)
        expect(request.fullpath).to eq edit_user_path(user.id)
      end
    end
  end
end
