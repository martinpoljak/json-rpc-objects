# encoding: utf-8
require "json-rpc-objects/v20/request"
require "yajl/json_gem"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Request module for version detection and universal API.
    #
    
    module Request
    
        ##
        # Parses JSON-RPC string for request and uses differential 
        # heuristic for detecting the right class.
        #
        # Be warn, it's impossible to distinguish JSON-RPC 1.1 Alt
        # and WD if there aren't keyword parameters in request. So 
        # requests without them are detected as WD. Set the default 1.1 
        # version by second argument.
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
                file = "json-rpc-objects/v20/request"
                cls = V20::Request
            elsif data.include? :version
                if (default_v11 == :alt) or (data.include? :kwparams)
                    file = "json-rpc-objects/v11/alt/procedure-call"
                    cls = V11::Alt::ProcedureCall
                else
                    file = "json-rpc-objects/v11/wd/procedure-call"
                    cls = V11::WD::ProcedureCall
                end
            else
                file = "json-rpc-objects/v10/request"
                cls = V10::Request
            end
            
            # Returns
            require file
            return cls::new(data)
        end
        
    
        ##
        # Returns request of the latest standard.
        # 
        # @param [Array] args for target constructor
        # @return [JsonRpcObjects::V20::Request]  request object
        #
        
        def self.create(*args)
            JsonRpcObjects::V20::Request::create(*args)
        end
                
    end
    
end
