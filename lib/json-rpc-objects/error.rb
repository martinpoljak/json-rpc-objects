# encoding: utf-8
require "json-rpc-objects/v20/error"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Error module for universal API.
    #
    
    module Error
            
        ##
        # Returns request of the latest standard.
        # 
        # @param [Array] args for target constructor
        # @return [JsonRpcObjects::V20::Error]  error object
        #
        
        def self.create(*args)
            JsonRpcObjects::V20::Error::create(*args)
        end
                
    end
    
end
