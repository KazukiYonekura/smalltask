RSpec.describe ApplicationHelper, type: :helper do
  describe "full_title表示テスト" do
    subject { full_title(page_title) }

    context "page_title is empty" do
      let(:page_title) { "" }

      it { is_expected.to eq("Small Task") }
    end

    context "page_title is nil" do
      let(:page_title) { nil }

      it { is_expected.to eq("Small Task") }
    end

    context "page_title is not empty" do
      let(:page_title) { "sample" }

      it { is_expected.to eq("sample - Small Task") }
    end
  end
end
