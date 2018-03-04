require "spec_helper"

describe Gpsoauth::Client do
  subject { described_class.new(id) }
  let(:id) { "9774d56d682e549c" }
  let(:host) { "127.0.0.1" }
  let(:port) { 8080 }
  let(:email) { "billclinton@gmail.com" }
  let(:password) { "password" }
  let(:oauth_args) { %w(foo bar bat baz) }

  describe "#initialize" do
    context "created with defaults" do
      its(:device_country) { should eq(described_class::DEFAULT_DEVICE_COUNTRY) }
      its(:lang) { should eq(described_class::DEFAULT_LANG) }
      its(:operator_country) { should eq(described_class::DEFAULT_OPERATOR_COUNTRY) }
      its(:sdk_version) { should eq(described_class::DEFAULT_SDK_VERSION) }
      its(:service) { should eq(described_class::DEFAULT_SERVICE) }
    end
  end

  describe "#use_proxy" do
    it "uses proxy" do
      subject.use_proxy(host, port)
      expect(subject.instance_variable_get(:@proxy_host)).to eq(host)
      expect(subject.instance_variable_get(:@proxy_port)).to eq(port)
    end
  end

  describe "#master_login" do
    it "provides a token" do
      response = subject.master_login(email, password)
      expect(response["Token"]).to eq("aaa")
    end
  end

  describe "#oauth" do
    it "provides a token" do
      response = subject.oauth(email, *oauth_args)
      expect(response["Auth"]).to eq("FQUb.")
    end
  end
end
