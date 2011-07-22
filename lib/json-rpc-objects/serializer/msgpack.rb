# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "json-rpc-objects/serializer"
require "msgpack"

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
        # MessagePack serializer using 'msgpack' gem.
        # @since 0.4.0
        #
        
        class MessagePack < Serializer 
                
            ##
            # Serializes data.
            #
            # @param [Object] data some data
            # @return [Object] object in serialized form
            #
            
            def serialize(data)
                ::MessagePack.pack(data)
            end
            
            ##
            # Deserializes data.
            #
            # @param [Object] data data in serialized form
            # @return [Object] deserialized data
            #
            
            def deserialize(data)
                ::MessagePack.unpack(data)
            end
    
        end
        
    end
end
    
    
