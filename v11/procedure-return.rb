# encoding: utf-8
require "yajl/json_gem"
require "hash-utils"
require "json-rpc-objects/v10/response"
require "json-rpc-objects/v11/error"

module JsonRpcObjects
    module V11
        class ProcedureReturn < JsonRpcObjects::V10::Response
        
            ##
            # Holds extensions.
            #
            
            @extensions
            attr_accessor :extensions
        
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
            
                data.merge! @extensions.map_keys { |k| k.to_s }
                return data.to_json
            end


            protected
            
            ##
            # Assigns request data.
            #

            def data=(value)  
                data = value.keys_to_sym
                super(data)
                
                if @error.kind_of? Hash
                    @error = JsonRpcObjects::V11::Error::new(@error)
                end
                
                data.delete(:result)
                data.delete(:error)
                data.delete(:id)
                
                # Extensions
                @extensions = data
            end
            
            ##
            # Converts request data to standard (defined) format.
            #
            
            def normalize!
                super()
                
                if @extensions.nil?
                    @extensions = { }
                end
            end
            
        end
    end
end
