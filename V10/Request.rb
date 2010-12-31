# encoding: utf-8
require "yajl/json_gem"

module JsonRpcObjects
    module V10
        class Request
        
            ##
            # Indicates length of ID.
            #
            
            ID_LENGTH = 25
        
            ##
            # Holds request data.
            #
            
            @data
        
            ##
            # Parses string for JSON-RPC request.
            #
            
            def self.parse(string)
                self::new(JSON.load(string))
            end
            
            ## 
            # Constructor.
            #
            
            def initialize(data)
                self.data = data
            end
            
            ##
            # Sets data.
            #
            
            def data=(value)
                if not value.kind_of? Hash
                    raise Exception::new("Invalid for JSON request.")
                end
                
                @data = { }
                value.each_pair do |k, v|
                    @data[k.to_sym] = v
                end
            end
            
            ##
            # Returns called method (as symbol).
            #
            
            def method
                @data[:method].to_sym
            end
            
            ##
            # Sets called method.
            #
            
            def method=(value)
                @data[:method] = value.to_s
            end
            
            ##
            # Returns method params.
            #
            
            def params
                @data[:params]
            end
            
            ##
            # Sets method params.
            #
            # Receives single value or array. Object will be serialized
            # to JSON, of sure, so must support the #to_json method.
            #
            
            def params=(value)
                if not value.kind_of? Array
                    value = [value]
                end
                
                @data[:params] = value
            end
            
            ##
            # Returns request ID.
            # Id ID isn't set, generates new one.
            #
            
            def id
                result = @data[:id]
                if result.nil?
                    self.id = self.generate_id!
                end
                
                return result
            end
            
            ##
            # Sets request ID.
            #
            
            def id=(value)
                @data[:id] = value
            end

            ##
            # Generates new task ID.
            #

            protected
            def generate_id!
                base = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHUJKLMNOPQRSTUVWXYZ"
                length = base.length - 1
                result = ""
                
                self.class::ID_LENGTH.times do
                    result << base[Kernel.rand(length)].chr
                end
                
                return result
            end
            
        end
    end
end
