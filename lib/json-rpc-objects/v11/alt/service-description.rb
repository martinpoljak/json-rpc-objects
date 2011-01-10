# encoding: utf-8
require "version"
require "addressable/uri"
require "json-rpc-objects/v11/alt/service-procedure-description"
require "json-rpc-objects/v11/wd/service-description"
require "json-rpc-objects/generic"
require "hash-utils/array"

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
