# encoding: utf-8
# (c) 2011-2015 Martin Poljak (martin@poljak.cz)

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module for utility functions. Large part ported from 'hash-utils'.
    # @since 0.4.4
    #
    
    module Utils
    
        ##
        # Object utility functions.
        #
        
        class Object
          
            ##
            # Returns +true+ if object is an instance of the given classes. 
            #
            # @see #kind_of_any?
            # @param [Object] object  source object
            # @param [Array] classes array of class objects
            # @return [Boolean] +true+ if it is, +false+ in otherwise
            #
            
            def self.instance_of_any?(object, *classes)
                if classes.first.kind_of? ::Array
                    classes = classes.first
                end
                
                classes.each do |cls|
                    if object.instance_of? cls
                        return true
                    end
                end
                
                return false
            end
            
            ##
            # Returns +true+ if one of classes are the class of object, 
            # or if one of classes are one of the superclasses of object or 
            # modules included in object.
            #
            # @param [Object] object  source object
            # @param [Array] classes array of class objects
            # @return [Boolean] +true+ if it is, +false+ in otherwise
            # @since 0.16.0
            #
            
            def self.kind_of_any?(object, *classes)
                if classes.first.kind_of? ::Array
                    classes = classes.first
                end
                
                classes.each do |cls|
                    if object.kind_of? cls
                        return true
                    end
                end
                
                return false
            end
            
            ##
            # Indicates, object is boolean.
            #
            # @param [Objectt] object  source object 
            # @return [Boolean] +true+ if yes, +false+ in otherwise
            #
            
            def self.boolean?(object)
                self.instance_of_any? object, [TrueClass, FalseClass]
            end
            
        end
        
    end
end
