# encoding: utf-8
require "hash-utils/hash"
require "json-rpc-objects/v10/request"
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
            # Procedure call (request) class.
            #
            
            class ProcedureCall < JsonRpcObjects::V10::Request
            
                include Extensions

                ##
                # Holds link to its version module.
                #
                
                VERSION = JsonRpcObjects::V11::WD
                
                ##
                # Holds JSON-RPC version specification.
                #
                
                VERSION_NUMBER = :"1.1"
                
                ##
                # Holds JSON-RPC version member identification.
                #
                
                VERSION_MEMBER = :version
                
                ##
                # Holds keyword parameters.
                #
                
                @keyword_parameters
                attr_accessor :keyword_parameters
                
                ##
                # Checks correctness of the request data.
                #
                
                def check!
                    super()
                    
                    if not @keyword_params.nil? and not @keyword_params.kind_of? Hash
                        raise Exception::new("Keyword params must be Hash.")
                    end
                end
                
                
                ##
                # Renders data to output hash.
                # @return [Hash] with data of call
                #
                
                def output
                    self.check!
                    
                    data = { }

                    # Version
                    __assign_version(data)
                    
                    # Method
                    data[:method] = @method.to_s
                    
                    # Params
                    __assign_params(data)
                    
                    # ID
                    if not @id.nil?
                        data[:id] = @id
                    end
                    
                    data.merge! @extensions                
                    return data
                end
                
                
                protected
                
                ##
                # Assigns request data.
                #

                def data=(value, mode = nil)
                    data = __convert_data(value, mode)
                    super(data, :converted)
                    
                    # Params
                    __get_params(data)
                    
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
                # Gets params from input.
                #
                
                def __get_params(data)
                
                    # If named arguments used, assigns keys as symbols
                    #   but keeps numeric arguments as integers
                    
                    if @params.kind_of? Hash
                        @params = @params.dup
                        @keyword_params = @params.remove! { |k, v| not k.numeric? }
                        @params = @params.sort_by { |i| i[0].to_i }.map { |i| i[1] }
                    else
                        @keyword_params = { }
                    end
                    
                    @keyword_params.map_keys! { |k| k.to_sym }
                    
                end
                
                ##
                # Assigns the parameters settings.
                #
                
                def __assign_params(data)
                    params = { }
                    
                    if not @params.nil?
                        @params.each_index do |i|
                            params[i.to_s.to_sym] = @params[i]
                        end
                    end
                    if not @keyword_params.nil?
                        params.merge! @keyword_params
                    end
                
                    data[:params] = params
                end
                            
                ##
                # Checks params data.
                #
                
                def __check_params
                    if not @params.nil? and not @params.kind_of? Array
                        raise Exception::new("Params must be Array.")
                    end
                end
                
                ##
                # Assignes the version specification.
                #
                
                def __assign_version(data)
                    data[self.class::VERSION_MEMBER] = self.class::VERSION_NUMBER
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
end

