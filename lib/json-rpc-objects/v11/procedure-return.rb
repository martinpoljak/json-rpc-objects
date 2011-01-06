# encoding: utf-8
require "yajl/json_gem"
require "hash-utils"
require "json-rpc-objects/v10/response"
require "json-rpc-objects/v11/error"

module JsonRpcObjects
    module V11
        class ProcedureReturn < JsonRpcObjects::V10::Response

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
                self.normalize!
                
                __check_coherency
                __check_error
            end
                                        
            ##
            # Renders data to output hash.
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
            
            ##
            # Handles method missing call for extensions.
            #
            
            def method_missing(name, *args)
                if name.to_s[-1].chr == ?=
                    self[name.to_s[0..-2].to_sym] = args.first
                else
                    self[name]
                end
            end
            
            ##
            # Handles array access as access for extensions too.
            #
            
            def [](name)
                @extensions[name]
            end
            
            ##
            # Handles array set to extensions.
            #
            
            def []=(name, value)
                @extensions[name] = value
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
                JsonRpcObjects::V11::Error::new(data)
            end
            
            ##
            # Checks error settings.
            #
            
            def __check_error
                if (not @error.nil?) and (not @error.kind_of? JsonRpcObjects::V11::Error)
                    raise Exception::new("Error object must be of type JsonRpcObjects::V11::Error.")
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
