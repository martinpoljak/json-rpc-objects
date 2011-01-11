# encoding: utf-8

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Generic version class.
    #
    
    class Version
    
        ##
        # Holds case switcher.
        #
        
        CASE_SWITCHER = /_\w/
    
        ##
        # Holds version module.
        #
        
        @module
        
        ##
        # Holds cache of class to module assignments.
        #
        
        @@cache = { }

        ##
        # Returns version object for appropriate version module.
        # @param [Module] mod appropriate version module
        # @return [Version] version object
        #
        
        def self.get(mod)
            if not @@cache.include? mod
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
            name = "_" << name.to_s
            name.gsub!(self.class::CASE_SWITCHER) { |s| s[1].chr.upcase }
            
            Kernel::eval(@module.name.dup << "::" << name)
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
