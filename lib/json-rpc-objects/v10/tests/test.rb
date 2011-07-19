# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

$:.push("../../..")
require "json-rpc-objects/serializer/bson"
JsonRpcObjects::default_serializer(JsonRpcObjects::Serializer::BSON)

require "../request"
req = JsonRpcObjects::V10::Request::create(:alfa, [:beta], :id => 12345)
puts req.serialize

require "../response"
res = JsonRpcObjects::V10::Response::create(true, nil, :id => 12345)
puts res.serialize

require "../response"
res = JsonRpcObjects::V10::Response::create(nil, "some problem", :id => 12345)
puts res.serialize


require "../../request"
puts JsonRpcObjects::Request::parse(req.to_json).inspect
require "../../response"
puts JsonRpcObjects::Response::parse(res.to_json).inspect
