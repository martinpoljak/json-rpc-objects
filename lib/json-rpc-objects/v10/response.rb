# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "json-rpc-objects/generic/response"
require "json-rpc-objects/v10/error"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module of JSON-RPC 1.0.
    # @see http://json-rpc.org/wiki/specification
    #

    module V10
    
        ##
        # Response object class.
        #
        
        class Response < JsonRpcObjects::Generic::Response

            ##
            # Holds link to its version module.
            #
            
            VERSION = JsonRpcObjects::V10

            ##
            # Identifies the error object class.
            #
            
            ERROR_CLASS = JsonRpcObjects::V10::Error
            
            ##
            # Holds result data.
            # @return [Object]
            #
        
            attr_accessor :result
            @result
            
            ##
            # Holds error data.
            # @return [JsonRpcObjects::V10::Error]
            #
            
            attr_accessor :error
            @error
            
            ##
            # Call ID.
            # @return [String]
            #
            
            attr_accessor :id
            @id

            ##
            # Creates new one.
            #
            # @param [Object] result of the call for response
            # @param [Object] error of the call for response
            # @param [Hash] opts additional options
            # @return [V10::Response] new response
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
                
                __check_coherency
                __check_id
                __check_error
            end
                        
            ##
            # Renders data to output hash.
            # @return [Hash] with data of response
            #
            
            def output
                self.check!
                
                if @error.nil?
                    error = nil
                else
                    error = @error.output
                end
                
                data = {
                    "result" => @result,
                    "error" => error,
                    "id" => @id
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
            
            ##
            # Indicates, response is error.
            #
            # @return [Boolean] +true+ if it's, +false+ otherwise
            # @since 0.3.0
            #
            
            def error?
                not @error.nil?
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
                
                __create_error
            end
            
            ##
            # Converts request data to standard (defined) format.
            #
                
            def normalize!
                __normalize_error
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
            
            ##
            # Creates error object.
            #
            
            def __create_error
                if not @error.nil? and not @error.kind_of? self.class::ERROR_CLASS
                    @error = self.class::ERROR_CLASS::new(@error)
                end
            end
            
            ##
            # Checks error settings.
            #
            
            def __check_error
                if not @error.nil?
                    if not @error.kind_of? self.class::ERROR_CLASS
                        raise Exception::new("Error object must be of type " << self.class::ERROR_CLASS.name << ".")
                    end
                    
                    @error.check!
                end
            end
            
            ##
            # Normalizes error.
            #
            
            alias :__normalize_error :__create_error
                        
        end
    end
end
