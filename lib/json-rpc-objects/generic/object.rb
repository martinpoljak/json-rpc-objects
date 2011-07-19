# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils/hash"
require "abstract"
require "json-rpc-objects/serializer"
require "json-rpc-objects/version"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module for generic object methods.
    #
    
    module Generic
    
        ##
        # Generic JSON-RPC Object.
        # @abstract
        #
        
        class Object
        
            ##
            # Holds assigned serializer.
            # @since 0.4.0
            #
            
            attr_accessor :serializer
            @serializer
        
            ##
            # Creates new one.
            #
            # @param [Array] args some arguments
            # @return [JsonRpcObjects::Generic::Object] new object
            # @abstract
            #
            
            def self.create(*args)
                not_implemented
            end
        
            ##
            # Returns the version object.
            # @return [JsonRpcObjects::Version]  appropriate version object
            #
            
            def self.version
                JsonRpcObjects::Version::get(self::VERSION)
            end
          
            ##
            # Parses serialized string.
            #
            # @param [Object] object with the serialized data
            # @param [JsonRpcObjects::Serializer] serializer instance of serializer class
            # @return [Generic::Object] of the given class
            #
            
            def self.parse(string, serializer = JsonRpcObjects::default_serializer)
                self::new(serializer.deserialize(string), serializer) 
            end
            
            ##
            # Converts object to JSON. It's deprecated and ineffective now.
            # Use the {#serialize} method.
            #
            # @see #serialize
            # @return [String]
            # @deprecated Since 0.4.0, replaced by +#serialize+.
            #
            
            def to_json
                JsonRpcObjects::Serializer::JSON::new.serialize(self.output)
            end
            
            ##
            # Serializes the object by the serializer.
            #
            # @return [Object]
            # @since 0.4.0
            #
            
            def serialize
                @serializer.serialize(self.output)
            end
                     
            ##
            # Constructor.
            #
            # @param [Hash] data for initializing the object
            # @param [JsonRpcObjects::Serializer] serializer instance of serializer class
            #
            
            def initialize(data, serializer = JsonRpcObjects::default_serializer)
                @serializer = serializer
                self.data = data
                self.check!
            end

            ##
            # Checks correctness of the request data.
            #
            
            def check!
                true
            end
                        
            ##
            # Renders data to output form.
            #
            # @return [Object] with data of object
            # @abstract
            #

            def output
                not_implemented
            end
            
            
            protected
            
            ##
            # Assigns request data.
            #

            def data=(value, mode = nil)
                not_implemented
            end
            
            ##
            # Converts data keys from strings to symbols if necessary.
            #
            
            def __convert_data(data, mode = nil)
                if mode != :converted
                    data.keys_to_sym
                else
                    data
                end
            end
            
            ##
            # Converts request data to standard (defined) format.
            #
            
            def normalize!
            end

        end
    end
end
