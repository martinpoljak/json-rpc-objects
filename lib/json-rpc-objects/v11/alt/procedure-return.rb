# encoding: utf-8
require "json-rpc-objects/v10/response"
require "json-rpc-objects/v11/alt/error"
require "json-rpc-objects/v11/wd/procedure-return"

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
            # Procedure return (response) class.
            #
            
            class ProcedureReturn < JsonRpcObjects::V11::WD::ProcedureReturn

                protected
                
                ##
                # Creates error object.
                #
                
                def __create_error(data)
                    JsonRpcObjects::V11::Alt::Error::new(data)
                end
                
                ##
                # Checks error settings.
                #
                
                def __check_error
                    if (not @error.nil?) and (not @error.kind_of? JsonRpcObjects::V11::Alt::Error)
                        raise Exception::new("Error object must be of type JsonRpcObjects::V11::Alt::Error.")
                    end
                end
                                
            end
        end
    end
end
