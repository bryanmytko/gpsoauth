require "spec_helper"

describe Gpsoauth::Keys do
  describe ".default" do
    it "returns a properly encoded key" do
      key = described_class.default
      expect(key).to be_a(String)
      expect(key.encoding.name).to eq("ASCII-8BIT")
    end
  end
end

