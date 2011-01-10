# encoding: utf-8
require "multitype-introspection"
require "json-rpc-objects/v11/generic-types"
require "json-rpc-objects/v11/wd/procedure-parameter-description"
require "json-rpc-objects/generic"

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
