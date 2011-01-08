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
            
            def self.parse(string)
                self::new(JSON.load(string))
            end

            ##
            # Creates new one.
            #
            
            def self.create(code, exception_or_message, opts = { })
                data = {
                    :code => code,
                }
                
                if exception_or_message.kind_of? Exception
                    data[:message] = exception_or_message.message
                    data[:error] = exception_or_message.backtrace
                else
                    data[:message] = exception_or_message
                end
                
                data.merge! opts
                return self::new(data)
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
