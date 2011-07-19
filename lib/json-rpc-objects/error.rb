# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

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
