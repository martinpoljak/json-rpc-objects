# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "json-rpc-objects/v11/wd/error"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # General module of JSON-RPC 1.1.
    #

    module V11
        
        ##
        # Module of JSON-RPC 1.1 Alternative.
        # @see http://groups.google.com/group/json-rpc/web/json-rpc-1-1-alt
        #
        
        module Alt
                
            ##
            # Error description object class for ProcedureReturn.
            #
            
            class Error < JsonRpcObjects::V11::WD::Error
            
                ##
                # Holds link to its version module.
                #
                
                VERSION = JsonRpcObjects::V11::Alt
                
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
                    result.delete("name")
                    
                    return result
                end
                                
            end
        end
    end
end
