# encoding: utf-8
require "yajl/json_gem"
require "hash-utils"
require "json-rpc-objects/generic"

module JsonRpcObjects
    module V11
        class Error < JsonRpcObjects::Generic::Object
        
            ##
            # Holds error code.
            #
            
            @code
            attr_accessor :code
            
            ##
            # Holds error message.
            #
            
            @message
            attr_accessor :message
            
            ##
            # Holds error data.
            #
            
            @data
            attr_accessor :data
            
            ##
            # Holds extensions.
            #
            
            @extensions
            attr_accessor :extensions

            ##
            # Parses JSON-RPC string.
            #
            # @param [String] string with the JSON data
            # @return [V11::Error] resultant error
            #
            
            def self.parse(string)
                JsonRpcObjects::Generic::Object::parse(self, string)
            end
            ##
            # Creates new one.
            #
            
            def self.create(code, exception_or_message, opts = { })
                data = {
                    :code => code,
                }
                
                if exception_or_message.kind_of? Exception
                    data[:message] = exception_or_message.message
                    data[:error] = exception_or_message.backtrace
                else
                    data[:message] = exception_or_message
                end
                
                data.merge! opts
                return self::new(data)
            end
            
            ##
            # Checks correctness of the data.
            #
            
            def check!
                self.normalize!

                if not @code.in? 100..999
                    raise Exception::new("Code must be between 100 and 999 including them.")
                end
            end

            ##
            # Renders data to output hash.
            # @return [Hash] with data of error
            #
            
            def output
                self.check!
                data = {
                    :name => :JSONRPCError,
                    :code => @code,
                    :message => @message
                }
                
                if not @error.nil?
                    data["error"] = @data
                end
                
                data.merge! @extensions.map_keys { |k| k.to_s }
                return data
            end
            
            ##
            # Handles method missing call for extensions.
            #
            # @param [Symbol] name of the method, setter if ends with '='
            # @param [Object] value for set
            # @return [Object] value set or get
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
            # @param [String] name of extension for return
            # @return [Object] value of extension member
            #
            
            def [](name)
                @extensions[name.to_sym]
            end
            
            ##
            # Handles array set to extensions.
            #
            # @param [String] name of extension for set
            # @param[Object] value of extension for set
            #
            
            def []=(name, value)
                @extensions[name.to_sym] = value
            end
            
                
            protected
            
            ##
            # Assigns data.
            #
            
            def data=(value, mode = nil)            
                data = __convert_data(value, mode)
             
                @code = data[:code]
                @message = data[:message]
                
                data.delete(:code)
                data.delete(:message)
                
                __assign_data(data)
                
                # Extensions
                @extensions = data
            end
            
            ##
            # Converts request data to standard (defined) format.
            #
            
            def normalize!
                @message = @message.to_s
                @code = @code.to_i
                
                if @extensions.nil?
                    @extensions = { }
                end
            end
            
            ##
            # Assigns error data.
            #
            
            def __assign_data(data)
                @data = data[:error]
                data.delete(:error)
            end

                  
        end
    end
end
