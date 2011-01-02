# encoding: utf-8
require "yajl/json_gem"
require "json-rpc-objects/v10/response"
require "json-rpc-objects/v11/error"

module JsonRpcObjects
    module V11
        class ProcedureReturn < JsonRpcObjects::V10::Response
        
            ##
            # Parses JSON-RPC string.
            #
            
            def self.parse(string)
                self::new(JSON.load(string))
            end

            ##
            # Creates new one.
            #
            
            def self.create(result = nil, error = nil, opts = { })
                data = {
                    :result => result,
                    :error => error
                }
                
                data.merge! opts
                return self::new(data)
            end
            
            ##
            # Checks correctness of the request data.
            #
            
            def check!
                self.normalize!
                if not @result.nil? and not @error.nil?
                    raise Exception::new("Either result or error must be nil.")
                end
                if (not @error.nil?) and (not @error.kind_of? JsonRpcObjects::V11::Error)
                    raise Exception::new("Error object must be of type JsonRpcObjects::V11::Error.")
                end
            end
                                        
            ##
            # Converts request back to JSON.
            #
            
            def to_json
                self.check!
                data = { "version" => "1.1" }
                
                if not @result.nil?
                    data["result"] = @result
                end
                
                if not @error.nil?
                    data["error"] = @error
                end

                if not @id.nil?
                    data["id"] = @id
                end                
                
                return data.to_json
            end


            protected
            
            ##
            # Assigns request data.
            #

            def data=(value)  
                super(value)
                
                if @error.kind_of? Hash
                    @error = JsonRpcObjects::V11::Error::new(@error)
                end
            end      
                  
        end
    end
end
