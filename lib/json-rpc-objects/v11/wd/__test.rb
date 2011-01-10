# encoding: utf-8
$:.push("../../..")

require "./procedure-call"
req = JsonRpcObjects::V11::WD::ProcedureCall::create(:alfa, {"0" => :beta, "something" => :alfa}, :id => 12345, :"$whatever" => false)
puts req.to_json

require "./error"
err = JsonRpcObjects::V11::WD::Error::create(200, "some problem")

require "./procedure-return"
res = JsonRpcObjects::V11::WD::ProcedureReturn::create(nil, err, :id => 12345)
puts res.to_json
res = JsonRpcObjects::V11::WD::ProcedureReturn::create(true, nil, :id => 12345)
puts res.to_json

require "./service-description"
sdesc = JsonRpcObjects::V11::WD::ServiceDescription::create(:alfa, 100)
puts sdesc.to_json

require "./service-procedure-description"
sproc = JsonRpcObjects::V11::WD::ServiceProcedureDescription::create(:some_proc)
sdesc << sproc
puts sdesc.to_json

require "./procedure-parameter-description"
sparam1 = JsonRpcObjects::V11::WD::ProcedureParameterDescription::create(:param1, :type => :str)
sparam2 = JsonRpcObjects::V11::WD::ProcedureParameterDescription::create(:param2, :type => JsonRpcObjects)
sproc << sparam1
sproc << sparam2
puts sdesc.to_json
