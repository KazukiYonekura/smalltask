RSpec.describe ApplicationHelper, type: :helper do
  describe "full_title表示テスト" do
    subject { full_title(page_title) }

    context "page_titleが空になっている場合" do
      let(:page_title) { "" }

      it { is_expected.to eq("Small_Task") }
    end

    context "page_titleがnilになっている場合" do
      let(:page_title) { nil }

      it { is_expected.to eq("Small_Task") }
    end

    context "page_titleが存在している場合" do
      let(:page_title) { "sample" }

      it { is_expected.to eq("sample - Small_Task") }
    end
  end
end
