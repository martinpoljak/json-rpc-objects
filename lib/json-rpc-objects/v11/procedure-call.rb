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
            # Renders data to output hash.
            #
            
            def output
                self.check!
                data = {  
                    "version" => "1.1",
                    "method" => @method.to_s
                }
                
                if (not @params.nil?) and (not @params.empty?)
                    data["params"] = @params
                end
                
                if not @id.nil?
                    data["id"] = @id
                end
                
                data.merge! @extensions.map_keys { |k| k.to_s }                
                return data
            end

            ##
            # Indicates, it's notification.
            # In 1.1 returns always false.
            #

            def notification?
                false
            end
            
            ##
            # Handles method missing call for extensions.
            #
            
            def method_missing(name, *args)
                if name.to_s[-1].chr == ?=
                    self[name.to_s[0..-2].to_sym] = args.first
                else
                    self[name]
                end
            end
            
            ##
            # Handles array access as access for extensions too.
            #
            
            def [](name)
                @extensions[name]
            end
            
            ##
            # Handles array set to extensions.
            #
            
            def []=(name, value)
                @extensions[name] = value
            end
            
            
            protected
            
            ##
            # Assigns request data.
            #

            def data=(value, mode = nil)
                data = __convert_data(value, mode)
                super(data, :converted)
                
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

