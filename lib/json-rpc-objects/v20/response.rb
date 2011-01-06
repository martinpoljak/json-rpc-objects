# encoding: utf-8
require "yajl/json_gem"
require "hash-utils"
require "multitype-introspection"
require "json-rpc-objects/v11/procedure-call"
require "json-rpc-objects/v20/error"

module JsonRpcObjects
    module V20
        class Response < JsonRpcObjects::V11::ProcedureReturn
           
            ##
            # Indicates ID has been set.
            #
            
            @_id_set
         
            ##
            # Parses JSON-RPC string.
            #
            
            def self.parse(string)
                self::new(JSON.load(string))
            end

            ##
            # Creates new one.
            #
            
            def self.create(result = nil, error = nil, opts = { })
                data = {
                    :result => result,
                    :error => error
                }
                
                data.merge! opts
                return self::new(data)
            end
            
            ##
            # Checks correctness of the request data.
            #
            
            def check!
                super()
                
                if not @id.kind_of_any? [String, Integer, NilClass]
                    raise Exception::new("ID must contain String, Number or nil if included.")
                end
            end
                                        
            ##
            # Renders data to output hash.
            #
            
            def output
                result = super()
                
                result.delete("version")
                result["jsonrpc"] = "2.0"
                
                if @_id_set and @id.nil?
                    result["id"] = nil
                end
                
                return result
            end
        

            protected
            
            ##
            # Assigns request data.
            #

            def data=(value, mode = nil)  
                data = __convert_data(value, mode)
                super(data, :converted)
                
                # Indicates, ID has been explicitly assigned
                @_id_set = data.include? :id
            end
            
            ##
            # Creates error object.
            #
            
            def __create_error(data)
                JsonRpcObjects::V20::Error::new(data)
            end
            

            ##
            # Checks error settings.
            #
            
            def __check_error
                if (not @error.nil?) and (not @error.kind_of? JsonRpcObjects::V20::Error)
                    raise Exception::new("Error object must be of type JsonRpcObjects::V20::Error.")
                end
            end
                    
        end
    end
end
