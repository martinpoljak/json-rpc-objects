# encoding: utf-8
require "json-rpc-objects/generic"

module JsonRpcObjects
    module V10
        class Request < JsonRpcObjects::Generic::Object
        
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
            # @param [String] string with the JSON data
            # @return [V10::Request] resultant request
            #
            
            def self.parse(string)
                JsonRpcObjects::Generic::Object::parse(self, string)
            end
            
            ##
            # Creates new one.
            #
            # @param [Symbol] method of the request
            # @param [Array] params array of arguments for the request
            # @param [Hash] opts additional options
            # @return [V10::Request] new request
            #
            
            def self.create(method, params = [ ], opts = { })
                self::generic_create(self, method, params, opts)
            end
            
            ##
            # Creates new request by generic way.
            #
            # @param [Class] cls class of new object
            # @param [Symbol] method of the request
            # @param [Array] params array of arguments for the request
            # @param [Hash] opts additional options
            # @return [V10::Request] new request or its child
            #
            
            def self.generic_create(cls, method, params = [ ], opts = { })
                data = {
                    :method => method,
                    :params => params
                }
                
                data.merge! opts
                return cls::new(data)
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
            # Renders data to output hash.
            # @return [Hash] with data of request
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
            # @return [Boolean] true if it is, otherwise false
            #

            def notification?
                @id.nil?
            end
            
            ##
            # Converts request data to standard (defined) format.
            # @return [nil]
            #
            
            def normalize!
                __normalize_method
                __normalize_params
            end

            
            
            protected
            
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
            
        end
    end
end
