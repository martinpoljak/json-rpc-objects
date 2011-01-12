# encoding: utf-8
require "json-rpc-objects/v11/wd/procedure-call"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # General module of JSON-RPC 1.1.
    #

    module V11
        
        ##
        # Module of Working Draft.
        # @see http://json-rpc.org/wd/JSON-RPC-1-1-WD-20060807.html
        #
        
        module WD
                
            ##
            # Fake procedure call (request) class.
            #
            
            class Request < JsonRpcObjects::V11::WD::ProcedureCall
            end
            
        end
    end
end

