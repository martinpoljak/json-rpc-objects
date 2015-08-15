# encoding: utf-8
# (c) 2011-2015 Martin Poljak (martin@poljak.cz)

require "json-rpc-objects/v11/alt/response"
require "json-rpc-objects/v20/error"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module of JSON-RPC 2.0.
    # @see http://groups.google.com/group/json-rpc/web/json-rpc-2-0
    #

    module V20

        ##
        # Response object class.
        #
    
        class Response < JsonRpcObjects::V11::Alt::Response
        
            ##
            # Holds link to its version module.
            #
            
            VERSION = JsonRpcObjects::V20
            
            ##
            # Identifies the error object class.
            #
            
            ERROR_CLASS = JsonRpcObjects::V20::Error
            
            ##
            # Holds JSON-RPC version specification.
            #
            
            VERSION_NUMBER = "2.0"
            
            ##
            # Holds JSON-RPC version member identification.
            #
            
            VERSION_MEMBER = "jsonrpc"
           
            ##
            # Indicates ID has been set.
            #
            
            @_id_set

            ##
            # Checks correctness of the request data.
            #
            
            def check!
                super()
                
                if not [Symbol, String, Integer, NilClass].any?{ |cl| @id.kind_of?(cl) }
                    raise Exception::new("ID must contain Symbol, String, Number or nil if included.")
                end
            end
                                        
            ##
            # Renders data to output hash.
            # @return [Hash] with data of error
            #
            
            def output
                result = super()
                
                if @_id_set and @id.nil?
                    result["id"] = nil
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
            # Assignes the version specification.
            #
            
            def __assign_version(data)
                data["jsonrpc"] = "2.0"
            end
                                
        end
    end
end
