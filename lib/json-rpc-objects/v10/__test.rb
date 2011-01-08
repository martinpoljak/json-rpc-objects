# encoding: utf-8
$:.push("../..")

require "./request"
req = JsonRpcObjects::V10::Request::create(:alfa, [:beta], :id => 12345)
puts req.to_json

require "./response"
res = JsonRpcObjects::V10::Response::create(true, nil, :id => 12345)
puts res.to_json
