# encoding: utf-8
require "json-rpc-objects/v11/alt/error"
require "json-rpc-objects/v11/wd/procedure-return"

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
            # Procedure return (response) class.
            #
            
            class ProcedureReturn < JsonRpcObjects::V11::WD::ProcedureReturn
            
                ##
                # Holds link to its version module.
                #
                
                VERSION = JsonRpcObjects::V11::Alt
                
                ##
                # Identified the error object class.
                #
                
                ERROR_CLASS = JsonRpcObjects::V11::Alt::Error
                
            end
        end
    end
end
