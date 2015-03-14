# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "json-rpc-objects/generic"
require "json-rpc-objects/v10/error"
require "json-rpc-objects/v11/wd/extensions"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # General module of JSON-RPC 1.1.
    #

    module V11
        
        ##
        # Module of Working Draft.
        # @see http://json-rpc.org/wd/JSON-RPC-1-1-WD-20060807.html
        #
        
        module WD
        
            ##
            # Error description object class for ProcedureReturn.
            #
            
            class Error < JsonRpcObjects::V10::Error
            
                include Extensions

                ##
                # Holds link to its version module.
                #
                
                VERSION = JsonRpcObjects::V11::WD
                            
                ##
                # Indicates data member name.
                #
                
                DATA_MEMBER_NAME = :error
            
                ##
                # Holds error code.
                # @return [Integer]
                #
                
                attr_accessor :code
                @code
                
                ##
                # Holds error message.
                # @return [String]
                #
                
                attr_accessor :message
                @message
                
                ##
                # Holds error data.
                # @return [Object]
                #
                
                attr_accessor :data
                @data

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
                        "name" => "JSONRPCError",
                        "code" => @code,
                        "message" => @message
                    }
                    
                    if not @data.nil?
                        data["error"] = @data
                    end
                    
                    data.merge! @extensions.map_keys { |k| k.to_s }
                    return data
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
end
