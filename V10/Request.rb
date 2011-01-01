# encoding: utf-8
require "yajl/json_gem"

module JsonRpcObjects
    module V10
        class Request < JsonRpcObjects::GenericObject
        
            ##
            # Holds request method name.
            #
        
            @method
            attr_accessor :method
            
            ##
            # Holds params for requested method.
            #
            
            @params
            attr_accessor :params
            
            ##
            # Call ID.
            #
            
            @id
            attr_accessor :id
            
            ##
            # Parses JSON-RPC request string.
            #
            
            def self.parse(string)
                self::new(JSON.load(string))
            end
            
            ##
            # Creates new JSON-RPC request.
            #
            
            def self.create(method, params = [ ], opts = { })
                data = {
                    :method => method,
                    :params => params
                }
                
                data.merge! opts
                return self::new(data)
            end
            
            ##
            # Checks correctness of the request data.
            #
            
            def check!
                self.normalize!
                if @method.nil?
                    raise Exception::new("Invalid method specification. Method cannot be nil.")
                end
            end
            
            ##
            # Converts request back to JSON.
            #
            
            def to_json
                self.check!
                @data.to_json
            end
            
            
            protected
            
            ##
            # Constructor.
            #
            
            def initialize(data)
                self.data = data
                self.check!
            end
            
            ##
            # Assigns request data.
            #

            def data=(value)            
                data = { }
                value.each_pair do |k, v|
                    data[k.to_sym] = v
                end
                
                @method = data[:method]
                @params = data[:params]
                @id = data[:id]
            end
            
            ##
            # Converts request data to standard (defined) format.
            #
            
            def normalize!
                # Corrects content
                if @method.kind_of_any? [String, Symbol]
                    @method = @method.to_sym
                end
                
                if @params.nil?
                    @params = [ ]
                end
            end
            
        end
    end
end
