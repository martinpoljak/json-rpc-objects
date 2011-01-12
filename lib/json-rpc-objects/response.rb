# encoding: utf-8
require "json-rpc-objects/v20/response"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Request module for version detection and universal API.
    #
    
    module Response

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
            data = JSON.load(string)
            
            if not data.kind_of? Hash
                raise Exception::new("Data in JSON string aren't object.")
            end
            
            data.keys_to_sym!
            
            # Detects
            if data.include? :jsonrpc
                file = "json-rpc-objects/v20/response"
                cls = V20::Response
            elsif data.include? :version
                if (default_v11 == :wd) or ((data.include? :error) and (data[:error].kind_of? Hash) and (data[:error].include? "name"))
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
            require file
            return cls::new(data)
        end
            
        ##
        # Returns request of the latest standard.
        # 
        # @param [Array] args for target constructor
        # @return [JsonRpcObjects::V20::Response]  response object
        #
        
        def self.create(*args)
            JsonRpcObjects::V20::Response::create(*args)
        end
                
    end
    
end
