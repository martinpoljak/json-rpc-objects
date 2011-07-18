# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

$:.push("../../..")

require "../request"
req = JsonRpcObjects::V10::Request::create(:alfa, [:beta], :id => 12345)
puts req.to_json

require "../response"
res = JsonRpcObjects::V10::Response::create(true, nil, :id => 12345)
puts res.to_json

require "../response"
res = JsonRpcObjects::V10::Response::create(nil, "some problem", :id => 12345)
puts res.to_json


require "../../request"
puts JsonRpcObjects::Request::parse(req.to_json).inspect
require "../../response"
puts JsonRpcObjects::Response::parse(res.to_json).inspect
