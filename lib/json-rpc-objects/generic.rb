# encoding: utf-8

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
            # Renders data to output Hash.
            #
            # @return [Hash] with data of object
            # @abstract
            #

            def output
                __abstract
            end
            
            
            
            protected
            
            ##
            # Assigns request data.
            # @abstract
            #

            def data=(value, mode = nil)
                __abstract
            end
            
            ##
            # Converts data keys from strings to symbols if necessary.
            
            # @param [Hash] data for conversion
            # @param [Symbol, nil] mode of the conversion, can 
            #   be :converted
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
            # @return [nil]
            #
            
            def normalize!
            end

            
            
            private
            
            ##
            # Raises method is abstract exception.
            #
            
            def __abstract
                raise Exception::new("Method is abstract.")
            end

        end
    end
end
