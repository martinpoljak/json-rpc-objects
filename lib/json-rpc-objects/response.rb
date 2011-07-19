# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "json-rpc-objects/v20/response"
require "hash-utils/object"
require "multi_json"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Emulates access to 2.0 response class.
    #
    # @see JsonRpcObjects::V20::Response
    # @since 0.2.0
    # 

    Response = JsonRpcObjects::V20::Response

    ##
    # Response class for version detection and universal API.
    # @since 0.2.0
    #
    
    class Response
    
        ##
        # Holds loaded files indicator.
        #
        
        @@files = { }

        ##
        # Parses JSON-RPC string for response and uses differential 
        # heuristic for detecting the right class.
        #
        # Be warn, it's impossible to distinguish JSON-RPC 1.1 Alt
        # and WD if there aren't error. So responsens without it are 
        # detected as WD. Set the default 1.1 version by second argument.
        #
        # @param [String] string JSON string for parse
        # @param [:wd, :alt] default_v11 type of the eventually returned 
        #   1.1 object
        #
        
        def self.parse(string, default_v11 = :wd)
            data = MultiJson.decode(string)
            
            if not data.hash?
                raise Exception::new("Data in JSON string aren't object.")
            end
            
            #data.keys_to_sym!
            
            # Detects
            if data.include? "jsonrpc"
                file = "json-rpc-objects/v20/response"
                cls = V20::Response
            elsif data.include? "version"
                if (default_v11 == :wd) or ((data.include? "error") and (data["error"].kind_of? Hash) and (data["error"].include? "name"))
                    file = "json-rpc-objects/v11/wd/procedure-return"
                    cls = V11::WD::ProcedureReturn
                else
                    file = "json-rpc-objects/v11/alt/procedure-return"
                    cls = V11::Alt::ProcedureReturn
                end
            else
                file = "json-rpc-objects/v10/response"
                cls = V10::Response
            end
            
            # Returns
            if not file.in? @@files
                require file
                @@files[file] = true
            end
            
            return cls::new(data)
        end
            
    end
    
end
