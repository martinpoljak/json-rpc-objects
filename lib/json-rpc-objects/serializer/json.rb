# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "json-rpc-objects/serializer"
require "multi_json"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects
    
    ##
    # Abstract serializer class.
    #
    # @since 0.4.0
    # @abstract
    #
    
    class Serializer
    
        ##
        # JSON serializer using +multi_json+.
        # @since 0.4.0
        #
        
        class JSON < Serializer 
                
            ##
            # Serializes data.
            #
            # @param [Object] data some data
            # @return [Object] object in serialized form
            #
            
            def serialize(data)
                MultiJson.encode(data)
            end
            
            ##
            # Deserializes data.
            #
            # @param [Object] data data in serialized form
            # @return [Object] deserialized data
            #
            
            def deserialize(data)
                MultiJson.decode(data)
            end
    
        end
        
    end
end
    
    
