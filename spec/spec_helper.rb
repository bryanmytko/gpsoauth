require "bundler/setup"
require "byebug"
require "webmock/rspec"

Bundler.setup

require "gpsoauth"

RSpec.configure do |config|
  config.before(:each) do
    token = "aaa"

    stub_request(:post, /.*android\.clients\.google\.com\/auth*/).
      to_return(status: 200,
                body: "SID=COOKIE\nLSID=OKIE\nAuth=FQUb.\nToken=#{token}"\
                      "\nservices=youtube,analytics,HOSTED\nfirstName=Bill"\
                      "\nlastName=Clinton\nGooglePlusUpdate=0\nEmail=billcli"\
                      "nton@gmail.com",
                headers: {})
  end
end
