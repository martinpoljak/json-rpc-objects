# encoding: utf-8
require "hash-utils"
require "json-rpc-objects/generic"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module of JSON-RPC 1.1.
    #

    module V11
    
        ##
        # Error description object class for ProcedureReturn.
        #
        
        class Error < JsonRpcObjects::Generic::Object
        
            ##
            # Indicates data member name.
            #
            
            DATA_MEMBER_NAME = :error
        
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
            # Creates new one.
            #
            # @param [Numeric] code od the error
            # @param [String, Exception] message of the error or 
            #   exception object
            # @param [Hash] opts additional options
            # @return [V11::Error] new error object
            #
                        
            def self.create(code, message, opts = { })
                data = {
                    :code => code,
                }
                
                if message.kind_of? Exception
                    data[:message] = message.message
                    data[self::DATA_MEMBER_NAME] = message.backtrace
                else
                    data[:message] = message
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
                    data[:error] = @data
                end
                
                data.merge! @extensions
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
