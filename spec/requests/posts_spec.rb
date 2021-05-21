RSpec.describe "Posts", type: :request do
  let(:user) { create(:user,) }
  let(:other_user) { create(:other_user) }

  def post_valid_information
    post posts_path, params: { post: { text: "aaa" } }
  end

  def patch_valid_information
    patch post_path, params: { post: { text: "bbb" } }
  end

  describe "POST /posts" do
    it "does not add a post when not logged in" do
      expect { post_valid_information }.not_to change(Post, :count)
      follow_redirect!
      expect(request.fullpath).to eq login_path
    end

    it "succeeds to add a post" do
      log_in_as(user)
      get user_path(user)
      expect { post_valid_information }.to change(Post, :count).by(1)
      follow_redirect!
      expect(request.fullpath).to eq user_path(user)
    end
  end

  describe "DELETE /post" do
    it "does not destroy a post when not logged in" do
      delete post_path(1)
      follow_redirect!
      expect(request.fullpath).to eq login_path
    end

    it "does not destroy a post when other users logged in" do
      log_in_as(user)
      get user_path(user)
      post_valid_information
      follow_redirect!
      delete logout_path
      log_in_as(other_user)
      get user_path(other_user)
      post_valid_information
      expect { delete post_path(user.posts.last.id) }.not_to change(Post, :count)
      expect { delete post_path(other_user.posts.last.id) }.to change(Post, :count).by(-1)
    end

    it "succeeds to destroy a post" do
      log_in_as(user)
      get user_path(user)
      expect { post_valid_information }.to change(Post, :count).by(1)
      follow_redirect!
      expect { delete post_path(user.posts.last.id) }.to change(Post, :count).by(-1)
      follow_redirect!
      expect(flash[:success]).to be_truthy
    end
  end

  describe "GET /posts/:id/edit" do
    it "does not edit a post when not logged in" do
      log_in_as(user)
      get user_path(user)
      post_valid_information
      follow_redirect!
      delete logout_path
      follow_redirect!
      get edit_post_path(user.posts.last.id)
      follow_redirect!
      expect(request.fullpath).to eq login_path
    end

    it "does not edit a post when other users logged in" do
      log_in_as(user)
      get user_path(user)
      post_valid_information
      follow_redirect!
      delete logout_path
      follow_redirect!
      log_in_as(other_user)
      get edit_post_path(user.posts.last.id)
      follow_redirect!
      expect(request.fullpath).to eq root_path
    end

    it "succeeds to edit a post" do
      log_in_as(user)
      get user_path(user)
      post_valid_information
      follow_redirect!
      get edit_post_path(user.posts.last.id)
      patch_valid_information
      follow_redirect!
      expect(request.fullpath).to eq user_path(user)
    end
  end
end
