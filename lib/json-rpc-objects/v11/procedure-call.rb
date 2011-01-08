# encoding: utf-8
require "multitype-introspection"
require "hash-utils"
require "json-rpc-objects/v10/request"
require "json-rpc-objects/generic"

module JsonRpcObjects
    module V11
        class ProcedureCall < JsonRpcObjects::V10::Request

            ##
            # Holds JSON-RPC version specification.
            #
            
            VERSION = :"1.1"
            
            ##
            # Holds JSON-RPC version member identification.
            #
            
            VERSION_MEMBER = :version
            
            ##
            # Holds extensions.
            #
            
            @extensions
            attr_accessor :extensions
        
            ##
            # Parses JSON-RPC string.
            #
            # @param [String] string with the JSON data
            # @return [V11::ProcedureCall] resultant procedure call
            #
            
            def self.parse(string)
                JsonRpcObjects::Generic::Object::parse(self, string)
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
                    :method => @method.to_s
                }
                
                __assign_version(data)
                
                if (not @params.nil?) and (not @params.empty?)
                    data[:params] = @params
                end
                
                if not @id.nil?
                    data[:id] = @id
                end
                
                data.merge! @extensions                
                return data
            end

            ##
            # Indicates, it's notification.
            # @return [Boolean] for JSON-RPC 1.1 returns always false.
            #

            def notification?
                false
            end
            
            ##
            # Handles method missing call for extensions.
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
            
            def [](name)
                @extensions[name.to_sym]
            end
            
            ##
            # Handles array set to extensions.
            #
            # @param [String] name of extension for return
            # @return [Object] value of extension member
            #
            
            def []=(name, value)
                @extensions[name.to_sym] = value
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
                
                __delete_version(data)
                
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

            ##
            # Assignes the version specification.
            #
            
            def __assign_version(data)
                data[self.class::VERSION_MEMBER] = self.class::VERSION
            end
            
            ##
            # Removes the version specification.
            #
            
            def __delete_version(data)
                data.delete(self.class::VERSION_MEMBER)
            end
                        
        end
    end
end

