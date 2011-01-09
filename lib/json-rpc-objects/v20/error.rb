# encoding: utf-8
require "yajl/json_gem"
require "hash-utils"
require "json-rpc-objects/v11/error"

module JsonRpcObjects
    module V20
        class Error < JsonRpcObjects::V11::Error
        
            ##
            # Parses JSON-RPC string.
            #
            # @param [String] string with the JSON data
            # @return [V20::Error] resultant error
            #
                        
            def self.parse(string)
                JsonRpcObjects::Generic::Object::parse(self, string)
            end

            ##
            # Creates new one.
            #
            # @param [Numeric] code od the error
            # @param [String, Exception] message of the error or 
            #   exception object
            # @param [Hash] opts additional options
            # @return [V20::Error] new error object
            #
            
            def self.create(code, message, opts = { })
                JsonRpcObjects::V11::Error::generic_create(self, :data, code, message, opts)
            end
            
            ##
            # Checks correctness of the data.
            #
            
            def check!
                self.normalize!

                if (@code.in? -32768..-32000) and not ((@code == -32700) or (@code.in? -32603..-32600) or (@code.in? -32099..-32000))
                    raise Exception::new("Code is invalid because of reserved space.")
                end
            end

            ##
            # Renders data to output hash.
            # @return [Hash] with data of error
            #
            
            def output
                result = super()
                
                if result.include? :error
                    result[:data] = result[:error]
                    result.delete(:error)
                end
            
                return result
            end
            
            
                
            protected
            
            ##
            # Assigns error data.
            #
            
            def __assign_data(data)
                @data = data[:data]
                data.delete(:data)
            end            
                  
        end
    end
end
