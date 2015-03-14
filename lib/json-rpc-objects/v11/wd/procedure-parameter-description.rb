# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "json-rpc-objects/v11/generic-types"
require "json-rpc-objects/generic"

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
            # Description of one procedure parameter.
            #
            
            class ProcedureParameterDescription < JsonRpcObjects::Generic::Object
            
                ##
                # Holds link to its version module.
                #
                
                VERSION = JsonRpcObjects::V11::WD
                
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
                # @return [Symbol]
                #
                
                attr_accessor :name
                @name
                
                ##
                # Holds parameter type.
                # @return [Class]
                #
                
                attr_accessor :type
                @type

                ##
                # Creates new one.
                #
                # @param [Symbol] name name of the parameter
                # @return [V11:ProcedureParameterDescription] new description object
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
                    
                    if not @name.symbol?
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
                    data = { "name" => @name.to_s }
                    
                    if not @type.nil?
                        data["type"] = __object_to_type.to_s
                    end
                    
                    return data
                end
                    
                    
                protected
                
                ##
                # Assigns request data.
                #
                
                def data=(value, mode = nil)
                    data = __convert_data(value, mode)
                    
                    @name = data[:name]
                    @type = data[:type]
                end
                
                ##
                # Converts request data to standard (defined) format.
                #
                
                def normalize!
                    if @name.string?
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
end
