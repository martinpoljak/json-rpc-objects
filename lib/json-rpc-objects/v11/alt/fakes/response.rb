# encoding: utf-8
require "json-rpc-objects/v11/alt/procedure-return"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # General module of JSON-RPC 1.1.
    #

    module V11
        
        ##
        # Module of JSON-RPC 1.1 Alternative.
        # @see http://groups.google.com/group/json-rpc/web/json-rpc-1-1-alt
        #
        
        module WD
                
            ##
            # Fake procedure return (response) class.
            #
            
            class Response < JsonRpcObjects::V11::Alt::ProcedureReturn
            end
            
        end
    end
end

