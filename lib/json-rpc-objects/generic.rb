# encoding: utf-8

module JsonRpcObjects
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
            # Renders data to output Hash.
            #
            # @return [Hash] with data of request
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
