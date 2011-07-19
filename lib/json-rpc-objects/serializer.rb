# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "json-rpc-objects/serializer/json"
require "abstract"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Holds the serializer.
    #

    @@serializer = JsonRpcObjects::Serializer::JSON::new

    ##
    # Sets the object serializer.
    # 
    # @param [Class, Module] serializer the serializer module
    # @since 0.4.0
    #
    
    def self.default_serializer(mod = nil)
        if mod.kind_of? Class
            mod = mod::new
        end
        
        @@serializer = mod if not mod.nil?
        @@serializer    # returns
    end
    
    ##
    # Serializes data.
    #
    # @param [Object] data some data
    # @return [Object] object in serialized form
    # @since 0.4.0
    #
    
    def self.serialize(data)
        @@serializer.serialize(data)
    end
    
    ##
    # Deserializes data.
    #
    # @param [Object] data data in serialized form
    # @return [Object] deserialized data
    # @since 0.4.0
    #
    
    def self.deserialize(data)
        @@serializer.deserialize(data)
    end


    ##
    # Abstract serializer class.
    #
    # @since 0.4.0
    # @abstract
    #
    
    class Serializer
        
        ##
        # Constructor.
        #
       
        def initialize
            if self.instance_of? Serializer
                not_implemented
            end
        end
                        
        ##
        # Serializes data.
        #
        # @param [Object] data some data
        # @return [Object] object in serialized form
        # @abstract
        #
        
        def serialize(data)
            not_implemented
        end
        
        ##
        # Deserializes data.
        #
        # @param [Object] data data in serialized form
        # @return [Object] deserialized data
        # @abstract
        #
        
        def deserialize(data)
            not_implemented
        end
        
    end
        
end

