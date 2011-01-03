# encoding: utf-8
require "yajl/json_gem"
require "json-rpc-objects/v10/request"
require "multitype-introspection"
require "hash-utils"

module JsonRpcObjects
    module V11
        class ProcedureCall < JsonRpcObjects::V10::Request
        
            ##
            # Parses JSON-RPC string.
            #
            
            def self.parse(string)
                self::new(JSON.load(string))
            end

            ##
            # Creates new one.
            #
            
            def self.create(method, params = [ ], opts = { })
                data = {
                    :method => method,
                    :params => params
                }
                
                data.merge! opts
                return self::new(data)
            end
                                        
            ##
            # Converts request back to JSON.
            #
            
            def to_json
                self.check!
                data = {  
                    "method" => @method.to_s,
                    "version" => "1.1"
                }
                
                if (not @params.nil?) and (not @params.empty?)
                    data["params"] = @params
                end
                
                if not @id.nil?
                    data["id"] = @id
                end
                
                return data.to_json
            end

            ##
            # Indicates, it's notification.
            # In 1.1 returns always false.
            #

            def notification?
                false
            end
            
            ##
            # Converts request data to standard (defined) format.
            #
            
            def normalize!
                __normalize_method
            end
            
            remove_method :__normalize_params

            
            
            protected
            
            ##
            # Assigns request data.
            #

            def data=(value)            
                super(value)
                
                # If named arguments used, assigns keys as symbols
                if @params.kind_of? Hash
                    @params = @params.keys_to_sym
                end
            end
            
            ##
            # Checks params data.
            #
            
            def __check_params
                if not @params.kind_of_any? [Array, Hash]
                    raise Exception::new("Params must be Array or Hash.")
                end
            end
            
        end
    end
end
