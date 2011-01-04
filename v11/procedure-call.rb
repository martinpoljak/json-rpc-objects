# encoding: utf-8
require "yajl/json_gem"
require "multitype-introspection"
require "hash-utils"
require "json-rpc-objects/v10/request"

module JsonRpcObjects
    module V11
        class ProcedureCall < JsonRpcObjects::V10::Request
        
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
                
                data.merge! @extensions.map_keys { |k| k.to_s }                
                return data.to_json
            end

            ##
            # Indicates, it's notification.
            # In 1.1 returns always false.
            #

            def notification?
                false
            end
            
            
            protected
            
            ##
            # Assigns request data.
            #

            def data=(value)
                data = value.keys_to_sym
                super(data)
                
                # If named arguments used, assigns keys as symbols
                if @params.kind_of? Hash
                    @params = @params.keys_to_sym
                end
                
                data.delete(:method)
                data.delete(:params)
                data.delete(:id)
                
                # Extensions
                @extensions = data
            end            
            
            ##
            # Converts request data to standard (defined) format.
            #
            
            def normalize!
                __normalize_method
                
                if @extensions.nil?
                    @extensions = { }
                end
            end
            
            remove_method :__normalize_params
            
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

