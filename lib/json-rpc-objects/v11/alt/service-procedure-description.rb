# encoding: utf-8
require "addressable/uri"
require "multitype-introspection"
require "types"
require "hash-utils/array"
require "json-rpc-objects/v11/alt/procedure-parameter-description"
require "json-rpc-objects/v11/wd/service-procedure-description"
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
            # Description of one procedure of the service.
            #
            
            class ServiceProcedureDescription < JsonRpcObjects::V11::WD::ServiceProcedureDescription
            
                ##
                # Indicates the service procedure description class.
                #
                
                PARAMETER_DESCRIPTION_CLASS = JsonRpcObjects::V11::Alt::ProcedureParameterDescription
                
                ##
                # Checks correctness of the data.
                #
                
                def check!
                    super()
                    
                    if (@params.kind_of? Array) and (not @params.all? { |v| v.type != JsonRpcObjects::V11::GenericTypes::Nil })
                        raise Exception::new("Nil return type isn't allowed for parameters.")
                    end
                end

            end
        end
    end
end
