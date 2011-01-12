# encoding: utf-8
require "json-rpc-objects/generic"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module of JSON-RPC 1.0.
    # @see http://json-rpc.org/wiki/specification
    #
    
    module V10
    
        ##
        # In fact, fake error class.
        #
        
        class Error < JsonRpcObjects::Generic::Object
      
            ##
            # Holds link to its version module.
            #
            
            VERSION = JsonRpcObjects::V10
            
            ##
            # Creates new one.
            #
            # @param [Object] data error data
            # @return [JsonRpcObjects::V10::Error] new object
            #
            
            def self.create(data)
                self::new(data)
            end
        
            ##
            # Holds request method name.
            #
        
            @data
            attr_accessor :data
            
            ##
            # Renders data to output form.
            # @return [Object] with data of object
            #

            def output
                @data
            end
            
            
            protected
            
            ##
            # Assigns request data.
            #

            def data=(value, mode = nil)
                @data = value
            end
            
        end
    end
end
