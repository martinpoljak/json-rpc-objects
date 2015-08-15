# encoding: utf-8
# (c) 2011-2015 Martin Poljak (martin@poljak.cz)

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module for utility functions. Large part ported from 'hash-utils'.
    # @since 0.4.4
    #
    
    module Utils
    
        ##
        # String utility functions.
        #
        
        class String
          
            ##
            # Holds numeric matcher.
            #
          
            NUMERIC = /^\s*-?\d+(?:\.\d+)?\s*$/
              
            ##
            # Indicates, string is numeric, so consists of numbers only.
            #
            # @param [Source] string  source string
            # @return [Boolean] +true+ if yes, +false+ in otherwise
            #
            
            def self.numeric?(string)
                if string.match(NUMERIC)
                    true
                else
                    false
                end
            end
        end
        
    end
end
