require "spec_helper"

describe Gpsoauth::Client do
  subject { described_class.new(id) }
  let(:id) { "9774d56d682e549c" }
  let(:host) { "127.0.0.1" }
  let(:port) { 8080 }

  describe "#use_proxy" do
    it "uses proxy" do
      subject.use_proxy(host, port)
      expect(subject.instance_variable_get(:@proxy_host)).to eq(host)
      expect(subject.instance_variable_get(:@proxy_port)).to eq(port)
    end
  end

  describe "#master_login" do
    it "provides token" do
      response = subject.master_login("billclinton@gmail.com", "password")
      expect(response["Token"]).to eq("aaa")
    end
  end
end
