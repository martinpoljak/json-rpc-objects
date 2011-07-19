# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "json-rpc-objects/serializer"
require "bson"

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
        # BSON serializer using +bson+.
        # @since 0.4.0
        #
        
        class BSON < Serializer 
                
            ##
            # Serializes data.
            #
            # @param [Object] data some data
            # @return [Object] object in serialized form
            #
            
            def serialize(data)
                ::BSON.serialize(data)
            end
            
            ##
            # Deserializes data.
            #
            # @param [Object] data data in serialized form
            # @return [Object] deserialized data
            #
            
            def deserialize(data)
                ::BSON.deserialize(data)
            end
    
        end
        
    end
end
    
    
