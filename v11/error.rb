# encoding: utf-8
require "yajl/json_gem"
require "hash-utils"

module JsonRpcObjects
    module V11
        class Error
        
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
            
            def self.parse(string)
                self::new(JSON.load(string))
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
                    data[:error] = exception.backtrace
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
            # Converts request back to JSON.
            #
            
            def to_json
                self.check!
                data = {
                    "name" => "JSONRPCError",
                    "code" => @code,
                    "message" => @message
                }
                
                if not @error.nil?
                    data["error"] = @data
                end
                
                data.merge! @extensions.map_keys { |k| k.to_s }
                return data.to_json
            end
                
                
                
            protected
            
            ##
            # Constructor.
            #
            
            def initialize(data)
                self.data = data
                self.check!
            end
            
            ##
            # Assigns request data.
            #
            
            def data=(value)            
                data = value.keys_to_sym
                
                @result = data[:result]
                @error = data[:error]
                @id = data[:id]
                
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
                @message = @message.to_s
                @code = @code.to_i
                
                if @extensions.nil?
                    @extensions = { }
                end
            end

                  
        end
    end
end

require "json-rpc-objects/v11/extensions"
