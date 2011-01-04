# encoding: utf-8
require "types"

module JsonRpcObjects
    module V11
        module GenericTypes
            class Any
            end
            
            class Nil
            end
            
            class Type < ::Types::Type
                ##
                # Only Any, Nil, Boolean, Integer, String, Array and Object
                # can be declared as type of parameter.
                #
                
                def type_classes
                    [Any, Nil, ::Boolean, ::Integer, ::String, ::Array, ::Object]
                end
            end
        end
    end
end
