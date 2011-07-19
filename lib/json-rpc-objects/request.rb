# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "json-rpc-objects/v20/request"
require "json-rpc-objects/serializer"
require "hash-utils/object"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Emulates access to 2.0 request class.
    #
    # @see JsonRpcObjects::V20::Request
    # @since 0.2.0
    # 

    Request = JsonRpcObjects::V20::Request

    ##
    # Request class for version detection and universal API.
    # @since 0.2.0
    #
    
    class Request

        ##
        # Holds loaded files indicator.
        #
        
        @@files = { }

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
        
        def self.parse(string, default_v11 = :wd, serializer = JsonRpcObjects::default_serializer)
            data = serializer.deserialize(string)
            
            if not data.hash?
                raise Exception::new("Data in JSON string aren't object.")
            end
            
            #data.keys_to_sym!
            
            # Detects
            if data.include? "jsonrpc"
                file = "json-rpc-objects/v20/request"
                cls = V20::Request
            elsif data.include? "version"
                if (default_v11 == :alt) or (data.include? "kwparams")
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
            if not file.in? @@files
                require file
                @@files[file] = true
            end
            
            return cls::new(data)
        end
                
    end
    
end
