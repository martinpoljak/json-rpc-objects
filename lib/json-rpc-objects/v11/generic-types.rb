# encoding: utf-8

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module of JSON-RPC 1.1.
    #

    module V11
    
        ##
        # Module for special generic types as they are defined 
        # in JSON-RPC 1.1.
        #
        
        module GenericTypes

            ##
            # Class which means "any type of JSON data", so
            # "Boolean, Number, String, Array or Object".
            #
        
            class Any
            end
            
            ##
            # Class which means classical nil. Nil in code means
            # type isn't defined, so this class is necessary.
            #
            
            class Nil
            end
            
            ##
            # Class which means Boolean, so true or false.
            #
            
            class Boolean
            end
            
        end
    end
end
