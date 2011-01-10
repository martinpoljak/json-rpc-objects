# encoding: utf-8
require "hash-utils"
require "json-rpc-objects/v11/wd/error"
require "json-rpc-objects/generic"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module of JSON-RPC 1.1.
    #

    module V11
        
        ##
        # Module of Alternative.
        #
        
        module Alt
                
            ##
            # Error description object class for ProcedureReturn.
            #
            
            class Error < JsonRpcObjects::V11::WD::Error
                
                ##
                # Checks correctness of the data.
                #
                
                def check!
                    self.normalize!
                end

                ##
                # Renders data to output hash.
                # @return [Hash] with data of error
                #
                
                def output
                    result = super()
                    result.delete(:name)
                    
                    return result
                end
                                
            end
        end
    end
end
