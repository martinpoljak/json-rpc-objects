# encoding: utf-8
require "yajl/json_gem"
require "hash-utils"

module JsonRpcObjects
    module V10
        class Request
        
            ##
            # Holds request method name.
            #
        
            @method
            attr_accessor :method
            
            ##
            # Holds params for requested method.
            #
            
            @params
            attr_accessor :params
            
            ##
            # Call ID.
            #
            
            @id
            attr_accessor :id
            
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
                self.normalize!
                __check_method
                __check_params
            end
                                        
            ##
            # Converts request back to JSON.
            #
            
            def to_json
                self.check!
                data = {
                    "method" => @method.to_s,
                    "params" => @params,
                    "id" => @id
                }
                
                return data.to_json
            end
            
            ##
            # Executes request on appropriate object.
            #
            
            def execute(object)
                object.send(@method.to_sym, *@params)
            end
            
            ##
            # Indicates, it's notification.
            #

            def notification?
                @id.nil?
            end
            
            ##
            # Converts request data to standard (defined) format.
            #
            
            def normalize!
                __normalize_method
                __normalize_params
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
                
                @method = data[:method]
                @params = data[:params]
                @id = data[:id]
            end
            
            ##
            # Checks method data.
            #
            
            def __check_method
                if not @method.kind_of? Symbol
                    raise Exception::new("Invalid method specification. Method must be Symbol (or, but indirectly String).")
                end
            end
            
            ##
            # Checks params data.
            #
            
            def __check_params
                if not @params.kind_of? Array
                    raise Exception::new("Params must be Array.")
                end
            end
            
            ##
            # Normalizes method.
            #
            
            def __normalize_method
                if @method.kind_of? String
                    @method = @method.to_sym
                end
            end
            
            ##
            # Normalizes params.
            #
            
            def __normalize_params
                if @params.nil?
                    @params = [ ]
                end
            end
            
        end
    end
end
