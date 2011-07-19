# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

$:.push("../../../..")

require "json-rpc-objects/serializer/marshal"
JsonRpcObjects::default_serializer(JsonRpcObjects::Serializer::Marshal)


require "../procedure-call"
req = JsonRpcObjects::V11::WD::ProcedureCall::create(:alfa, {"0" => :beta, "something" => :alfa}, :id => 12345, :"$whatever" => false)
puts req.serialize

require "../error"
err = JsonRpcObjects::V11::WD::Error::create(200, "some problem")

require "../procedure-return"
res = JsonRpcObjects::V11::WD::ProcedureReturn::create(nil, err, :id => 12345)
puts res.serialize
res = JsonRpcObjects::V11::WD::ProcedureReturn::create(true, nil, :id => 12345)
puts res.serialize

require "../service-description"
sdesc = JsonRpcObjects::V11::WD::ServiceDescription::create(:alfa, 100, :version => "1.2.34")
puts sdesc.serialize

require "../service-procedure-description"
sproc = JsonRpcObjects::V11::WD::ServiceProcedureDescription::create(:some_proc)
sdesc << sproc
puts sdesc.serialize

require "../procedure-parameter-description"
sparam1 = JsonRpcObjects::V11::WD::ProcedureParameterDescription::create(:param1, :type => :str)
sparam2 = JsonRpcObjects::V11::WD::ProcedureParameterDescription::create(:param2, :type => JsonRpcObjects)
sproc << sparam1
sproc << sparam2
puts sdesc.serialize

require "../../../request"
puts JsonRpcObjects::Request::parse(req.serialize).inspect
require "../../../response"
puts JsonRpcObjects::Response::parse(res.serialize).inspect

puts req.class::version.response::create(25)
