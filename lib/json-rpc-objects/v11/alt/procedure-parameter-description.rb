# encoding: utf-8
require "json-rpc-objects/v11/wd/procedure-parameter-description"

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
        
        module Alt
                    
            ##
            # Description of one procedure parameter.
            #
            
            class ProcedureParameterDescription < JsonRpcObjects::V11::WD::ProcedureParameterDescription
            end
            
        end
    end
end
