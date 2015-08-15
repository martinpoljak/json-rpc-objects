JSON-RPC Objects
================

**JSON-RPC Objects** is complete implementation of by [JSON-RPC][1] 
defined objects with respect to specifications compliance and API 
backward compatibility. It implements all versions of the protocol and 
support for ability to communicate by the same protocol version which 
the other side uses by a transparent way.

It means, it implements following JSON-RPC versions:

* [1.0][2] (*original specification*)
* [1.1 WD][3] (*working draft*)
* [1.1 Alt][4] (*alternative proposal*)
* [2.0][5] (*revised specification proposal*)

### Protocol Versions Compatibility

All protocols are implemented from point of view of features which must
complain to. Some of these features aren't encouraged to use, but it's 
on will of the user. 2.0 and 1.1 Alt implement some minor additions 
in comparing to specification such as object extensions as defined in 
1.1 WD, but mainly because of API compatibility and functionallity 
reasons.

All classes inherit from previous protocol version classes so API is 
homogenous. Application which can deal with 1.0 can deal with 2.0 too 
without any funcionallity or logic lost. 

### Usage
  
All object classes have three creating class methods:

* `#create(<some arguments>, opts = { })` &ndash; which creates new 
object according to arguments (required members) and options (optional 
members),
* `#parse(string)` &ndash; which parses the JSON string,
* `#new(data)` &ndash; which creates new object from hash.

All names of both class names and optional arguments are exactly the 
same as defined in specification.

Library can be used by two ways. You know either concrete version of the 
protocol which you want to use in your application (typically client) 
or you process some incoming request which can use whatever of 
the versions (typically server).

Concrete version use example (creates call to `subtract` method with 
ID "a2b3"):

```ruby
require "json-rpc-objects/v10/request"
require "json-rpc-objects/v11/alt/request"
require "json-rpc-objects/v20/request"

JsonRpcObjects::V10::Request::create(:subtract, ["1", "2"], :id => "a2b3")
JsonRpcObjects::V11::Alt::Request::create(:subtract, ["1", "2"], :id => "a2b3")
JsonRpcObjects::V20::Request::create(:subtract, ["1", "2"], :id => "a2b3")
```

Or incoming data processing request:

```ruby
require "json-rpc-objects/request"
JsonRpcObjects::Request::parse(string)
```

…which will simply return request object of appropriate class according 
to its version. Be warn, to distinguish between 1.1 Alt and 1.1 WD is
impossible in most of cases. It isn't problem for simple use, but it 
can be problem in some special cases. Default is WD, but Alt can be set
as default if it's required.

### Transparent Processing

In some cases, for example in case implementing of JSON-RPC server, you 
need make response to request by the same protocol version. It can be 
achieved by simple way:

```ruby
require "json-rpc-objects/request"

request = JsonRpcObjects::Request::parse(string)
# ... <data processing>
response = request.class::version.response::create(<some args>)
```

This code analyzes protocol version of the request and creates response
of the same protocol version. It utilizes call handler, so you can call
for example `request.class::version.service_procedure_description::create(<arguments>)`
for obtaining 1.1 service procedure description object. But be warn, 
neither 1.0 nor 2.0 implements these objects, so it can simply cause 
`LoadError` in that case, therefore it really isn't recommended.

Be limited by `Error`, `Request` and `Response` classes here or check
the protocol version using `#VERSION` class constant.

### Serializers

Multiple serializers support is implemented, so you aren't limited to
JSON[8] only, but you can use also built-in serializer to 
[Ruby marshaling][10] format or serializers to [YAML][9], [BSON][11] 
and others. At this time, the following serializer gems are available:

* [json-rpc-objects-json][20] – JSON using the [multi_json][12] gem for
widespread compatibility,
* [json-rpc-objects-yaml][21] – [YAML][9] using the standard library 
[Ruby Syck][13],
* [json-rpc-objects-bson][22] – [BSON][11] format of MongoDB,
* [json-rpc-objects-msgpack][23] – very fast [MessagePack][14] format,
* [json-rpc-objects-psych][24] – [YAML][9] using more modern 
[libyaml][15] library.

You can set the default serializer for whole library session (both class
and instance of the class are supported):

```ruby
require "json-rpc-objects/serializer/marshal"

JsonRpcObjects::default_serializer(JsonRpcObjects::Serializer::Marshal)

# it's setting default serializer for all new instances, without
# arguments it returns the default serializer
```
    
Or by individual object assigning (only instances are supported):

```ruby
require "json-rpc-objects/serializer/marshal"

serializer = JsonRpcObjects::Serializer::Marshal::new
JsonRpcObjects::V10::Request::parse(data, serializer)
```

…and the same for constructor. The `#serializer` property is also 
accessible, both readable and writable on all objects. By the same way, 
serializer is received by the generic parsers `JsonRpcObjects::Request` 
and so too. 

Copyright
---------

Copyright &copy; 2011-2015 [Martin Poljak][7]. See `LICENSE.txt` for
further details.

[1]: http://en.wikipedia.org/wiki/JSON-RPC
[2]: http://json-rpc.org/wiki/specification
[3]: http://json-rpc.org/wd/JSON-RPC-1-1-WD-20060807.html
[4]: http://groups.google.com/group/json-rpc/web/json-rpc-1-1-alt
[5]: http://groups.google.com/group/json-rpc/web/json-rpc-2-0
[6]: http://github.com/martinkozak/json-rpc-objects/issues
[7]: http://www.martinpoljak.net/

[9]: http://www.yaml.org/
[10]: http://ruby-doc.org/core/classes/Marshal.html
[11]: http://bsonspec.org/
[12]: http://github.com/intridea/multi_json
[13]: http://www.ruby-doc.org/stdlib/libdoc/syck/rdoc/index.html
[14]: http://msgpack.org/
[15]: http://pyyaml.org/wiki/LibYAML

[20]: https://github.com/martinkozak/json-rpc-objects-json
[21]: https://github.com/martinkozak/json-rpc-objects-yaml
[22]: https://github.com/martinkozak/json-rpc-objects-bson
[23]: https://github.com/martinkozak/json-rpc-objects-msgpack
[24]: https://github.com/martinkozak/json-rpc-objects-psych
