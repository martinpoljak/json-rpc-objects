# encoding: utf-8
require "yajl/json_gem"
require "multitype-introspection"
require "hash-utils"
require "json-rpc-objects/v11/generic-types"
require "json-rpc-objects/generic"

module JsonRpcObjects
    module V11
        class ProcedureParameterDescription < JsonRpcObjects::Generic::Object
        
            ##
            # Maps type to object (class).
            #
            
            TYPE_TO_OBJECT = Hash::define({
                :num => Integer,
                :str => String,
                :arr => Array,
                :obj => Object,
                :bit => GenericTypes::Boolean,
                :nil => GenericTypes::Nil,
                :any => GenericTypes::Any
            }, GenericTypes::Any)
            
            ##
            # Maps object (class) to type.
            #
            
            OBJECT_TO_TYPE = Hash::define({
                Integer => :num,
                String => :str,
                Array => :arr,
                Object => :obj,
                GenericTypes::Boolean => :bit,
                GenericTypes::Nil => :nil,
                GenericTypes::Any => :any
            }, :any)
        
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
            # @param [String] string with the JSON data
            # @return [V11::ProcedureParameterDescription] resultant description
            #
                        
            def self.parse(string)
                JsonRpcObjects::Generic::Object::parse(self, string)
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
                
                if (not @type.nil?) and (not @type.kind_of_any? [GenericTypes::Any, GenericTypes::Nil, GenericTypes::Boolean, Integer, String, Array, Object])
                    raise Exception::new("Type if defined can be only Any, Nil, Boolean, Integer, String, Array or Object.")
                end
            end
            
            ##
            # Renders data to output hash.
            # @return [Hash] with data of description
            #
            
            def output
                self.check!
                data = { :name => @name.to_s }
                
                if not @type.nil?
                    data[:type] = __object_to_type
                end
                
                return data
            end
                
                
            protected
            
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
                self.class::TYPE_TO_OBJECT[@type.to_sym]
            end
            
            ## 
            # Converts type object to type definition.
            #
            
            def __object_to_type
                self.class::OBJECT_TO_TYPE[@type]
            end

        end
    end
end
