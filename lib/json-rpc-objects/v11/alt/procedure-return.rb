# encoding: utf-8
require "json-rpc-objects/v11/alt/error"
require "json-rpc-objects/v11/wd/procedure-return"

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
            # Procedure return (response) class.
            #
            
            class ProcedureReturn < JsonRpcObjects::V11::WD::ProcedureReturn
            
                ##
                # Identified the error object class.
                #
                
                ERROR_CLASS = JsonRpcObjects::V11::Alt::Error
                
            end
        end
    end
end
