# encoding: utf-8
require "hash-utils"
require "multi_json_compat"
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
            # Creates new one.
            #
            # @param [Array] args some arguments
            # @return [JsonRpc::Generic::Object] new object
            #
            
            def self.create(*args)
                __abstract
            end
        
            ##
            # Returns the version object.
            # @return [JsonRpcObjects::Version]  appropriate version object
            #
            
            def self.version
                JsonRpcObjects::Version::get(self::VERSION)
            end
          
            ##
            # Parses JSON-RPC string.
            #
            # @param [String] string with the JSON data
            # @return [Generic::Object] of the given class
            #
            
            def self.parse(string)
                self::new(JSON.load(string)) 
            end
                        
            ##
            # Converts back to JSON.
            # @return [String]
            #
            
            def to_json
                self.output.to_json
            end
                     
            ##
            # Constructor.
            # @param [Hash] data for initializing the object
            #
            
            def initialize(data)
                self.data = data
                self.check!
            end

            ##
            # Checks correctness of the request data.
            #
            
            def check!
            end
                        
            ##
            # Renders data to output form.
            #
            # @return [Object] with data of object
            # @abstract
            #

            def output
                __abstract
            end
            
            
            protected
            
            ##
            # Assigns request data.
            #

            def data=(value, mode = nil)
                __abstract
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

            
            private
            
            ##
            # Raises method is abstract exception.
            #
            
            def __abstract
                self.class::__abstract
            end
            
            ##
            # Raises method is abstract exception.
            #
            
            def self.__abstract
                raise Exception::new("Method is abstract.")
            end

        end
    end
end
