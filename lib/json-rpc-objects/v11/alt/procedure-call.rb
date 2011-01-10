# encoding: utf-8
require "hash-utils"
require "json-rpc-objects/v11/wd/procedure-call"
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
            # Procedure call (request) class.
            #
            
            class ProcedureCall < JsonRpcObjects::V11::WD::ProcedureCall
                
                protected
                
                ##
                # Assigns request data.
                #

                def data=(value, mode = nil)
                    data = __convert_data(value, mode)
                    super(data, :converted)
                    
                    data.delete(:kwparams)
                end            

                ##
                # Gets params from input.
                #
                
                def __get_params(data)
                    @params = data[:params]

                    # For alternative specification merges with 'kwparams'
                    #   property.
                    if data.include? :kwparams
                       @keyword_params = data[:kwparams]
                       @keyword_params.map_keys! { |k| k.to_sym }
                    end
                end
                
                ##
                # Assigns the parameters settings.
                #
                
                def __assign_params(data, version = :wd)
                    if not @params.nil? and not @params.empty?
                        data[:params] = @params
                    end
                    if not @keyword_params.nil? and not @keyword_params.empty?
                        data[:kwparams] = @keyword_params
                    end
                end
                                            
            end
        end
    end
end
