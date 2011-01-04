# encoding: utf-8
require "yajl/json_gem"
require "types"
require "multitype-introspection"
require "hash-utils"
require "json-rpc-objects/v11/generic-types"

module JsonRpcObjects
    module V11
        class ProcedureParameterDescription
        
            ##
            # Holds parameter name.
            #
            
            @name
            attr_accessor :name
            
            ##
            # Holds parameter type.
            #
            
            @type
            attr_accessor :type
            
            ##
            # Parses JSON-RPC string.
            #
            
            def self.parse(string)
                self::new(JSON.load(string))
            end

            ##
            # Creates new one.
            #
            
            def self.create(name, opts = { })
                data = { :name => name }
                data.merge! opts
                return self::new(data)
            end
            
            ##
            # Checks correctness of the data.
            #
            
            def check!
                self.normalize!
                
                if not @name.kind_of? Symbol
                    raise Exception::new("Parameter name must be Symbol or convertable to Symbol.")
                end
                
                if (not @type.nil?) and (not @type.type_of? GenericTypes::Type)
                    raise Exception("Type if defined can be only Any, Nil, Boolean, Integer, String, Array or Object.")
                end
            end
            
            ##
            # Converts back to JSON.
            #
            
            def to_json
                self.check!
                data = { "name" => @name.to_s }
                
                if not @type.nil?
                    data["type"] = __object_to_type
                end
                
                return data.to_json
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
                
                @name = data[:name]
                @type = data[:type]
            end
            
            ##
            # Converts request data to standard (defined) format.
            #
            
            def normalize!
                if @name.kind_of? String
                    @name = @name.to_sym
                end

                if @type.kind_of_any? [String, Symbol]
                    @type = __normalize_type
                end
            end
            
            ##
            # Normalizes type definition.
            #
            
            def __normalize_type
                __type_to_object
            end
            
            ##
            # Converts type definition to appropriate object.
            #
            
            def __type_to_object
                case @type.to_sym
                    when :bit
                        ::Boolean
                    when :num
                        ::Integer
                    when :str
                        ::String
                    when :arr
                        ::Array
                    when :obj
                        ::Object
                    when :nil
                        GenericTypes::Nil
                    when :any
                        GenericTypes::Any
                    else
                        GenericTypes::Any
                end
            end
            
            ## 
            # Converts type object to type definition.
            #
            
            def __object_to_type
                case @type.name.to_sym
                    when :Boolean
                        "bit"
                    when :Integer
                        "num"
                    when :String
                        "str"
                    when :Array
                        "arr"
                    when :Object
                        "obj"
                    when :"JsonRpcObjects::V11::GenericTypes::Any"
                        "any"
                    when :"JsonRpcObjects::V11::GenericTypes::Nil"
                        "nil"
                end
            end

        end
    end
end
