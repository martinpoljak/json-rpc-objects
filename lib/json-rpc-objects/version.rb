# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils/object"
require "hash-utils/module"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Generic version class.
    #
    
    class Version
    
        ##
        # Holds class name generator for internal use.
        #
        
        CLASS_NAME_GENERATOR = /_\w/
        
        ##
        # Holds file name generator for internal use.
        #
        
        FILE_NAME_GENERATOR = /[a-z0-9][A-Z]/
    
        ##
        # Holds version module.
        #
        
        @module
        
        ##
        # Holds cache of class to module assignments.
        #
        
        @@cache = { }
        
        ##
        # Holds loaded files indicator.
        #
        
        @@files = { }

        ##
        # Returns version object for appropriate version module.
        #
        # @param [Module] mod appropriate version module
        # @return [Version] version object
        #
        
        def self.get(mod)
            if not mod.in? @@cache
                @@cache[mod] = self::new(mod)
            end
            
            @@cache[mod]
        end

        ##
        # Handles unknown call as request for appropriate class.
        #
        # Camel case is defined by underscores, so for example <tt>
        # #some_class<tt> will be transformed to <tt>SomeClass</tt>.
        #
        # @param [Symbol] name  formatted object name
        # @return [JsonRpcObjects::Generic::Object]  object of appropriate version
        #
        
        def method_missing(name)
            name = name.to_s 
        
            # Class name
            class_name = "_" << name
            class_name.gsub!(self.class::CLASS_NAME_GENERATOR) { |s| s[1].chr.upcase }

            # Module name
            module_name = @module.name + "::" + class_name
            
            # File path
            file_path = "x" << module_name
            file_path.gsub!(self.class::FILE_NAME_GENERATOR) { |s| s[0].chr << "-" <<  s[1].chr }
            file_path.replace(file_path[2..-1])
            file_path.gsub!("::", "/")
            file_path.downcase!
            
            if not @@files.has_key? file_path
                require file_path
                @@files[file_path] = true
            end
            
            return Module.get_module(module_name)
        end
        
        
        protected
            
        ##
        # Constructor.
        #
        
        def initialize(mod)
            @module = mod
        end
        
    end
    
end
