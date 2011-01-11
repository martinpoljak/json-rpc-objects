# encoding: utf-8
require "json-rpc-objects/v11/alt/service-procedure-description"
require "json-rpc-objects/v11/wd/service-description"

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
            # Service description object class.
            #
            
            class ServiceDescription < JsonRpcObjects::V11::WD::ServiceDescription
            
                ##
                # Indicates the procedure parameter description class.
                #
                
                PROCEDURE_DESCRIPTION_CLASS = JsonRpcObjects::V11::Alt::ServiceProcedureDescription
                
            end
        end
    end
end
