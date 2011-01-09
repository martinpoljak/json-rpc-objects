# encoding: utf-8
require "json-rpc-objects/generic"

module JsonRpcObjects
    module V10
        class Response < JsonRpcObjects::Generic::Object
        
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
            # @param [String] string with the JSON data
            # @return [V10::Response] resultant response
            #
            
            def self.parse(string)
                JsonRpcObjects::Generic::Object::parse(self, string)
            end
            
            ##
            # Creates new one.
            #
            # @param [Object] result of the call for response
            # @param [Object] error of the call for response
            # @param [Hash] opts additional options
            # @return [V10::Response] new response
            #
            
            def self.create(result = nil, error = nil, opts = { })
                self::generic_create(self, result, error, opts)
            end
            
            ##
            # Creates new response by generic way.
            #
            # @param [Class] cls class of new object
            # @param [Object] result of the call for response
            # @param [Object] error of the call for response
            # @param [Hash] opts additional options
            # @return [V10::Response] new response or its child
            #
            
            def self.generic_create(cls, result = nil, error = nil, opts = { })
                data = {
                    :result => result,
                    :error => error
                }
                
                data.merge! opts
                return cls::new(data)
            end
            
            ##
            # Checks correctness of the request data.
            #
            
            def check!
                __check_coherency
                __check_id
            end
                        
            ##
            # Renders data to output hash.
            # @return [Hash] with data of response
            #
            
            def output
                self.check!
                data = {
                    :result => @result,
                    :error => @error,
                    :id => @id
                }
                
                return data
            end
            
            ## 
            # Receives result by array fill operator.
            # @param [Object] result for the response
            #
            
            def <<(result)
                @result = result
            end
            
            
            protected
            
            ##
            # Assigns request data.
            #

            def data=(value, mode = nil)            
                data = __convert_data(value, mode)
                
                @result = data[:result]
                @error = data[:error]
                @id = data[:id]
            end

            ##
            # Checks coherency of result and error.
            #
            
            def __check_coherency
                if not @result.nil? and not @error.nil?
                    raise Exception::new("Either result or error must be nil.")
                end
            end
            
            ##
            # Checks ID.
            #
            def __check_id
                if @id.nil?
                    raise Exception::new("ID is required for 1.0 responses.")
                end           
            end 
                        
        end
    end
end