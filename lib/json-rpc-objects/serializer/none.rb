# encoding: utf-8
# (c) 2012 Martin Kozák (martinkozak@martinkozak.net)

require "json-rpc-objects/serializer"

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
        # +None+ serializer which doesn't serialize at all.
        # @since 0.4.3
        #
        
        class None < Serializer 
                
            ##
            # Serializes data.
            #
            # @param [Object] data some data
            # @return [Object] object in serialized form
            #
            
            def serialize(data)
                data
            end
            
            ##
            # Deserializes data.
            #
            # @param [Object] data data in serialized form
            # @return [Object] deserialized data
            #
            
            def deserialize(data)
                data
            end
    
        end
        
    end
end
    
    
