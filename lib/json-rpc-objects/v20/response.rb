# encoding: utf-8
require "multitype-introspection"
require "json-rpc-objects/v10/response"
require "json-rpc-objects/v11/procedure-return"
require "json-rpc-objects/v20/error"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module of JSON-RPC 2.0.
    #

    module V20

        ##
        # Response object class.
        #
    
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
