# encoding: utf-8
require "json-rpc-objects/v11/wd/procedure-parameter-description"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module of JSON-RPC 1.1.
    #

    module V11

        ##
        # Module of Alternative.
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
