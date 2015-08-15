# encoding: utf-8
# (c) 2011-2015 Martin Poljak (martin@poljak.cz)

require "json-rpc-objects/v11/wd/request"
require "json-rpc-objects/utils"

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
            # Procedure call (request) class.
            #
            
            class ProcedureCall < JsonRpcObjects::V11::WD::Request
            
                ##
                # Holds link to its version module.
                #
                
                VERSION = JsonRpcObjects::V11::Alt
                
                
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
                       JsonRpcObjects::Utils::Hash.keys_to_sym! @keyword_params
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
