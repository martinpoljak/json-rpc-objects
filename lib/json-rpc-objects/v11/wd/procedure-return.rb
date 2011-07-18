# encoding: utf-8
require "json-rpc-objects/v10/response"
require "json-rpc-objects/v11/wd/error"
require "json-rpc-objects/v11/wd/extensions"
require "hash-utils/object"

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
            # Procedure return (response) class.
            #
            
            class ProcedureReturn < JsonRpcObjects::V10::Response
            
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
                # Identifies the error object class.
                #
                
                ERROR_CLASS = JsonRpcObjects::V11::WD::Error
                
                ##
                # Checks correctness of the request data.
                #
                
                def check!
                    self.normalize!
                    
                    __check_coherency
                    __check_error
                end
                                            
                ##
                # Renders data to output hash.
                # @return [Hash] with data of return
                #
                
                def output
                    self.check!
                    
                    data = { }
                    __assign_version(data)
                    
                    if not @result.nil?
                        data[:result] = @result
                    end
                    
                    if not @error.nil?
                        data[:error] = @error
                    end

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
                    
                    data.delete(:result)
                    data.delete(:error)
                    data.delete(:id)
                    
                    __delete_version(data)
                    
                    # Extensions
                    @extensions = data
                end
                
                ##
                # Converts request data to standard (defined) format.
                #
                
                def normalize!
                    if @extensions.nil?
                        @extensions = { }
                    end
                end
                
                ##
                # Creates error object.
                #
                
                def __create_error
                    if @error.hash?
                        @error = self.class::ERROR_CLASS::new(@error)
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
