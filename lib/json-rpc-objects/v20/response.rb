# encoding: utf-8
require "multitype-introspection"
require "json-rpc-objects/v10/response"
require "json-rpc-objects/v11/procedure-return"
require "json-rpc-objects/v20/error"

module JsonRpcObjects
    module V20
        class Response < JsonRpcObjects::V11::ProcedureReturn
        
            ##
            # Holds JSON-RPC version specification.
            #
            
            VERSION = :"2.0"
            
            ##
            # Holds JSON-RPC version member identification.
            #
            
            VERSION_MEMBER = :jsonrpc
           
            ##
            # Indicates ID has been set.
            #
            
            @_id_set

            ##
            # Parses JSON-RPC string.
            #
            # @param [String] string with the JSON data
            # @return [V20::Response] resultant response
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
            # @return [V20::Response] new response
            #
            
            def self.create(result = nil, error = nil, opts = { })
                JsonRpcObjects::V10::Response::generic_create(self, result, error, opts)
            end
            
            ##
            # Checks correctness of the request data.
            #
            
            def check!
                super()
                
                if not @id.kind_of_any? [String, Integer, NilClass]
                    raise Exception::new("ID must contain String, Number or nil if included.")
                end
            end
                                        
            ##
            # Renders data to output hash.
            # @return [Hash] with data of error
            #
            
            def output
                result = super()
                
                if @_id_set and @id.nil?
                    result[:id] = nil
                end
                
                return result
            end
        

            protected
            
            ##
            # Assigns request data.
            #

            def data=(value, mode = nil)  
                data = __convert_data(value, mode)
                super(data, :converted)
                
                # Indicates, ID has been explicitly assigned
                @_id_set = data.include? :id
            end
            
            ##
            # Creates error object.
            #
            
            def __create_error(data)
                JsonRpcObjects::V20::Error::new(data)
            end
            

            ##
            # Checks error settings.
            #
            
            def __check_error
                if (not @error.nil?) and (not @error.kind_of? JsonRpcObjects::V20::Error)
                    raise Exception::new("Error object must be of type JsonRpcObjects::V20::Error.")
                end
            end

            ##
            # Assignes the version specification.
            #
            
            def __assign_version(data)
                data[:jsonrpc] = :"2.0"
            end
                                
        end
    end
end
