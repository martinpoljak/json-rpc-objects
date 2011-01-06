# encoding: utf-8
require "yajl/json_gem"
require "hash-utils"
require "multitype-introspection"
require "json-rpc-objects/v11/procedure-call"

module JsonRpcObjects
    module V20
        class Request < JsonRpcObjects::V11::ProcedureCall
        
            ##
            # Holds extensions.
            #
            
            @extensions
            attr_accessor :extensions
            
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
            
            def self.create(method, params = [ ], opts = { })
                data = {
                    :method => method,
                    :params => params
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
            # Converts request back to JSON.
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

            ##
            # Indicates, it's notification.
            # In 1.1 returns always false.
            #

            def notification?
                not @_id_set
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
            
        end
    end
end
