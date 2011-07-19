# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

$:.push("../../..")

require "json-rpc-objects/serializer/marshal"
JsonRpcObjects::default_serializer(JsonRpcObjects::Serializer::Marshal)


require "../request"
req = JsonRpcObjects::V20::Request::create(:alfa, {:alfa => :beta}, :id => :"12345", :"$whatever" => false)
puts req.serialize
req = JsonRpcObjects::V20::Request::create(:alfa, [:beta], :"version" => :"1.0")
puts req.serialize

require "../error"
err = JsonRpcObjects::V20::Error::create(200, "some problem", :data => "Additional data.")

require "../response"
res = JsonRpcObjects::V20::Response::create(nil, err, :id => 12345)
puts res.serialize
res = JsonRpcObjects::V20::Response::create(true, nil, :id => 12345)
puts res.serialize

require "../../request"
puts JsonRpcObjects::Request::parse(req.serialize).inspect
require "../../response"
puts JsonRpcObjects::Response::parse(res.serialize).inspect

puts req.class::version.response::create(25)
