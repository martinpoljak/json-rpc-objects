# encoding: utf-8
require "multitype-introspection"
require "json-rpc-objects/v11/procedure-call"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module of JSON-RPC 2.0.
    #

    module V20
    
        ##
        # Request object class.
        #
        
        class Request < JsonRpcObjects::V11::ProcedureCall

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
            # @return [V20::Request] resultant request
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

            ##
            # Indicates, it's notification.
            # @return [Boolean] true if it is, otherwise false
            #

            def notification?
                not @_id_set
            end
            
           
            
            protected
            
            ##
            # Assigns request data.
            #

            def data=(value, mode = nil)
                data = __convert_data(value, mode)
                
                # Indicates, ID has been explicitly assigned
                @_id_set = data.include? :id
                
                super(data, :converted)
            end            
            
        end
    end
end
