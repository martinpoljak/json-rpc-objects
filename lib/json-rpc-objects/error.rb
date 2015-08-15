# encoding: utf-8
# (c) 2011-2015 Martin Poljak (martin@poljak.cz)

require "json-rpc-objects/v20/error"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Emulates access to 2.0 error class.
    #
    # @see JsonRpcObjects::V20::Error
    # @since 0.2.0
    # 

    Error = JsonRpcObjects::V20::Error

end
