require 'spec_helper'
require 'json-rpc-objects/request'

describe JsonRpcObjects::Request do
  describe "#parse" do
    let(:json) { '{"jsonrpc":"2.0","method":"sum","params":[1,2],"id":"cbf5d56b"}' }
    subject(:request) { described_class.parse(json) }
    its(:method) { should == :sum }
    its(:params) { should == [1,2] }
  end
end
