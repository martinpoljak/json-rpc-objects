# encoding: utf-8

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # General module of JSON-RPC 1.1.
    #

    module V11
    
        ##
        # Module of Working Draft.
        # @see http://json-rpc.org/wd/JSON-RPC-1-1-WD-20060807.html
        #
        
        module WD
            
            ##
            # Module for extension support in JSON-RPC 1.1 WD.
            #
            
            module Extensions
                   
                ##
                # Holds extensions.
                #
                
                @extensions
                attr_accessor :extensions
                
                ##
                # Handles method missing call for extensions.
                #
                # @param [Symbol] name of the method, setter if ends with '='
                # @param [Object] value for set
                # @return [Object] value set or get
                #
                
                def method_missing(name, *args)
                    if name.to_s[-1].chr == ?=
                        self[name.to_s[0..-2]] = args.first
                    else
                        self[name]
                    end
                end
                
                ##
                # Handles array access as access for extensions too.
                #
                # @param [String] name of extension for return
                # @return [Object] value of extension member
                #
                
                def [](name)
                    @extensions[name.to_sym]
                end
                
                ##
                # Handles array set to extensions.
                #
                # @param [String] name of extension for set
                # @param[Object] value of extension for set
                #
                
                def []=(name, value)
                    @extensions[name.to_sym] = value
                end

            end
        end
    end
end
