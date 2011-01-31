# encoding: utf-8
require "json-rpc-objects/generic/object"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module for generic object methods.
    #
    
    module Generic
    
        ##
        # Generic JSON-RPC request.
        #
        # @since 0.3.0
        # @abstract
        #
        
        class Request < JsonRpcObject::Generic::Object
        end
        
    end
end
