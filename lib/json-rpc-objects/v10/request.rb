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
                self.output.to_json
            end
            
            ##
            # Renders data to output hash.
            #
            
            def output
                self.check!
                data = {
                    :method => @method.to_s,
                    :params => @params,
                    :id => @id
                }                
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

            def data=(value, mode = nil)            
                data = __convert_data(value, mode)
                
                @method = data[:method]
                @params = data[:params]
                @id = data[:id]
            end
            
            ##
            # Checks method data.
            #
            
            def __check_method
                if not @method.kind_of? Symbol
                    raise Exception::new("Service name must be Symbol or convertable to Symbol.")
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
            
            ##
            # Converts data keys from strings to symbols if necessary.
            #
            
            def __convert_data(data, mode = nil)
                if mode != :converted
                    data.keys_to_sym
                else
                    data
                end
            end
            
        end
    end
end
