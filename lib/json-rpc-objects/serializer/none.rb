# encoding: utf-8
# (c) 2011-2015 Martin Poljak (martin@poljak.cz)

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
    
    
