# encoding: utf-8
# (c) 2011-2015 Martin Poljak (martin@poljak.cz)

$:.push("../../../..")

require "json-rpc-objects/serializer/marshal"
JsonRpcObjects::default_serializer(JsonRpcObjects::Serializer::Marshal)


require "../procedure-call"
req = JsonRpcObjects::V11::Alt::ProcedureCall::create(:alfa, [:foo, :bar], :kwparams => {"0" => :beta, "something" => :alfa}, :id => 12345, :"$whatever" => false)
puts req.serialize

require "../error"
err = JsonRpcObjects::V11::Alt::Error::create(200, "some problem")

require "../procedure-return"
res = JsonRpcObjects::V11::Alt::ProcedureReturn::create(nil, err, :id => 12345)
puts res.serialize
res = JsonRpcObjects::V11::Alt::ProcedureReturn::create(true, nil, :id => 12345)
puts res.serialize

require "../service-description"
sdesc = JsonRpcObjects::V11::Alt::ServiceDescription::create(:alfa, 100)
puts sdesc.serialize

require "../service-procedure-description"
sproc = JsonRpcObjects::V11::Alt::ServiceProcedureDescription::create(:some_proc)
sdesc << sproc
puts sdesc.serialize

require "../procedure-parameter-description"
sparam1 = JsonRpcObjects::V11::Alt::ProcedureParameterDescription::create(:param1, :type => :str)
sparam2 = JsonRpcObjects::V11::Alt::ProcedureParameterDescription::create(:param2, :type => JsonRpcObjects)
sproc << sparam1
sproc << sparam2
puts sdesc.serialize


require "../../../request"
puts JsonRpcObjects::Request::parse(req.serialize).inspect
require "../../../response"
puts JsonRpcObjects::Response::parse(res.serialize, :alt).inspect

puts req.class::version.response::create(25)
