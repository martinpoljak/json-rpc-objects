# encoding: utf-8
require "yajl/json_gem"
require "hash-utils"

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
            # Parses JSON-RPC string.
            #
            
            def self.parse(string)
                self::new(JSON.load(string))
            end
            
            ##
            # Creates new one.
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
            # Receives result by array fill operator.
            #
            
            def <<(result)
                @result = result
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
                data = value.keys_to_sym
                
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
