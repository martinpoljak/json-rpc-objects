# encoding: utf-8
$:.push("../..")

require "./request"
req = JsonRpcObjects::V20::Request::create(:alfa, [:beta], :id => 12345, :"$whatever" => false)
puts req.to_json
req = JsonRpcObjects::V20::Request::create(:alfa, [:beta], :id => nil, :"version" => :"1.0")
puts req.to_json

require "./error"
err = JsonRpcObjects::V20::Error::create(200, "some problem")

require "./response"
res = JsonRpcObjects::V20::Response::create(nil, err, :id => 12345)
puts res.to_json
res = JsonRpcObjects::V20::Response::create(true, nil, :id => 12345)
puts res.to_json

