JSON-RPC Objects
================

**Hash Utils** implementation of JSON-RPC objects with respect to 
specifications compliance and API backward compatibility. Implements all 
versions of the protocol and support for abiliimty to communicate by the 
same version of the protocol which other side uses by a transparent way.

It means it implements following versions:

* [1.0][1] (*original specification*)
* [1.1 WD][2] (*working draft*)
* [1.1 Alt][3] (*alternative proposal*)
* [2.0][4] (*revised specification proposal*)

### Protocol Versions Compatibility

All protocols are implemented from points of view of features which must
complain to. Some of these aren't encouraged, but it's on will of the 
user. 2.0 and 1.1 Alt implements some minor additions compared to 
specification such as object extensions as defined in 1.1 WD, but mainly
because of API compatibility and functionallity reasons.

All class inherits previous versions so API is homogenous. Application 
which can deal with 1.0 can deal with 2.0 too without any funcionallity 
lost. But be warn, it doesn't apply to logical changes although API is
compatible, so for example 1.1 request classes will always return 
`false` for `#notification?` method because notification simply 
logically doesn't exists in these versions.

### Usage

All object classes have three creating class methods:

* `create(<some arguments>, opts = { })` &ndash; which creates new 
object according to arguments (required members) and options (optional members),
* `parse(string)` &ndash; which parses the JSON string,
* `new(data)` &ndash; which creates new object from hash.

All names both class and optional arguments are the same as in specification.

It can be used by two ways. You know either concrete version of the 
protocol which you want to use in your application (typically client) or
you process incoming request by several versions.

Concrete version use (creates call to `subtract` method with ID "a2b3"):
    
    JsonRpcObjects::V10::Request::create(:subtract, ["1", "2"], :id => "a2b3")
    JsonRpcObjects::V11::Alt::Request::create(:subtract, ["1", "2"], :id => "a2b3")
    JsonRpcObjects::V20::Request::create(:subtract, ["1", "2"], :id => "a2b3")
    
Or incoming data processing request:

    JsonRpcObjects::Request::parse(string)
    
…which will simply return request object of appropriate class according 
to its version. Be warn, to distinguish between 1.1 Alt and 1.1 WD is
impossible in a lot of cases. It isn't problem for simple use, but it 
can by problem in some special cases.

### Transparent Processing

In some cases, for example in case of JSON-RPC server you need make 
response to request by the same protocol version. It can be achieved by
simple way:

    request = JsonRpcObjects::Request::parse(string)
    ...
    response = request.class::version.response::create(<some data>)
    
This code analyzes protocol version of the request and create response
of the same protocol version. I utilizes call handler, so you can call
fo example `request.class::version.service_procedure_description(<arguments>)`
for obtaining 1.1 service procedure description object. But be warn 
again, neither 1.0 nor 2.0 implements these objects, so it can simply 
cause `LoadError` in that case therefore it really isn't recommended.

Be limited by `Error`, `Request` and `Response` classes here or check
the protocol version using `VERSION` class constant.

Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b 20101220-my-change`).
3. Commit your changes (`git commit -am "Added something"`).
4. Push to the branch (`git push origin 20101220-my-change`).
5. Create an [Issue][5] with a link to your branch.
6. Enjoy a refreshing Diet Coke and wait.


Copyright
---------

Copyright &copy; 2011 [Martin Kozák][6]. See `LICENSE.txt` for
further details.

[1]: http://www.ruby-doc.org/core/classes/Array.html
[2]: http://www.ruby-doc.org/core/classes/Hash.html
[3]: http://www.ruby-doc.org/core/classes/Array.html#M000278
[4]: http://www.ruby-doc.org/core/classes/Array.html#M000279
[5]: http://github.com/martinkozak/json-rpc-objects/issues
[6]: http://www.martinkozak.net/
