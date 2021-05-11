RSpec.describe "Logins", type: :system do
  let(:user) { create(:user) }

  describe "Login" do
    context "invalid" do
      it "is invalid because it has no information" do
        visit login_path
        expect(page).to have_selector '.login-container'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        find(".form-submit").click
        expect(current_path).to eq login_path
        expect(page).to have_selector '.login-container'
        expect(page).to have_selector '.alert-danger'
      end

      it "deletes flash messages when users input invalid information then other links" do
        visit login_path
        expect(page).to have_selector '.login-container'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        find(".form-submit").click
        expect(current_path).to eq login_path
        expect(page).to have_selector '.login-container'
        expect(page).to have_selector '.alert-danger'
        visit root_path
        expect(page).not_to have_selector '.alert-danger'
      end
    end

    context "valid" do
      it "is valid because it has valid information" do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        find(".form-submit").click
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_selector '.show-container'
      end

      it "contains logout button without login button" do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        find(".form-submit").click
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_selector '.show-container'
      end
    end

    describe "Logout" do
      it "contains login button without logout button" do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        find(".form-submit").click
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_selector '.show-container'
        click_on 'ログアウト'
        expect(current_path).to eq root_path
        expect(page).to have_selector '.home-container'
      end
    end
  end
end
