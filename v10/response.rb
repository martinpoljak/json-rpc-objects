# encoding: utf-8
require "yajl/json_gem"

module JsonRpcObjects
    module V10
        class Response
        
            ##
            # Holds result data.
            #
        
            @result
            attr_accessor :result
            
            ##
            # Holds error data.
            #
            
            @error
            attr_accessor :error
            
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
            # Creates new JSON-RPC response.
            #
            
            def self.create(result = nil, error = nil, opts = { })
                data = {
                    :result => result,
                    :error => error
                }
                
                data.merge! opts
                return self::new(data)
            end
            
            ##
            # Checks correctness of the request data.
            #
            
            def check!
                self.normalize!
                if not @result.nil? and not @error.nil?
                    raise Exception::new("Either result or error must be nil.")
                end
                if @id.nil?
                    raise Exception::new("ID is required for 1.0 responses.")
                end
            end
            
            ##
            # Converts request back to JSON.
            #
            
            def to_json
                self.check!
                data = {
                    "result" => @result,
                    "error" => @error,
                    "id" => @id
                }
                
                return data.to_json
            end
            
            ##
            # Executes request on appropriate object.
            #
            
            def execute(object)
                object.send(@method.to_sym, *@params)
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
                
                @result = data[:result]
                @error = data[:error]
                @id = data[:id]
            end
            
            ##
            # Converts request data to standard (defined) format.
            #
            
            def normalize!
            end
            
        end
    end
end
