RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { user.posts.build(content: "task1", text: "Lorem ipsum", user_id: user.id, created_at: 10.minutes.ago) }
  let(:post2) { user.posts.build(content: "  ", text: "  ", user_id: user.id) }

  describe "post" do
    it "is valid" do
      expect(post).to be_valid
    end

    it "is not valid" do
      expect(post2).to be_invalid
    end
  end

  describe "user_id" do
    it "is not present" do
      post.user_id = nil
      expect(post).to be_invalid
    end
  end

  describe "memo" do
    it "is not at most 255 characters" do
      post.text = "a" * 255
      expect(post).to be_valid
      post.text = "a" * 256
      expect(post).to be_invalid
    end
  end
end
