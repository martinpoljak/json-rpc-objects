# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils/numeric"
require "json-rpc-objects/v11/alt/error"

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
        # Error description object class for Response.
        #
        
        class Error < JsonRpcObjects::V11::Alt::Error
        
            ##
            # Holds link to its version module.
            #
            
            VERSION = JsonRpcObjects::V20

            ##
            # Indicates data member name.
            #
            
            DATA_MEMBER_NAME = :data
            
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
                
                if @data.nil?
                    super(data)
                end
            end

        end
    end
end
