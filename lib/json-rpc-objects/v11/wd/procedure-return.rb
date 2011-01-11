# encoding: utf-8
require "json-rpc-objects/v10/response"
require "json-rpc-objects/v11/wd/error"
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
            # Procedure return (response) class.
            #
            
            class ProcedureReturn < JsonRpcObjects::V10::Response
            
                include Extensions

                ##
                # Holds JSON-RPC version specification.
                #
                
                VERSION = :"1.1"
                
                ##
                # Holds JSON-RPC version member identification.
                #
                
                VERSION_MEMBER = :version
                
                ##
                # Identified the error object class.
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
                    
                    if @error.kind_of? Hash
                        @error = __create_error(@error)
                    end
                    
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
                
                def __create_error(data)
                    self.class::ERROR_CLASS::new(data)
                end
                
                ##
                # Checks error settings.
                #
                
                def __check_error
                    if not @error.nil?
                        if not @error.kind_of? self.class::ERROR_CLASS
                            raise Exception::new("Error object must be of type " << self.class::ERROR_CLASS.name << ".")
                        end
                        
                        @error.check!
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
end
