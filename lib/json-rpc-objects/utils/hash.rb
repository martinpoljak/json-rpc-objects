# encoding: utf-8
# (c) 2011-2015 Martin Poljak (martin@poljak.cz)

require 'ruby-version'

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
        # Hash utility functions.
        #
        
        class Hash
          
            ##
            # Returns a new hash with the results of running block once for 
            # every key in +hash+.
            #
            # @param [Hash] hash  source hash
            # @param [Proc] block evaluating block
            # @return [Hash] new hash
            #
            
            def self.map_keys(hash, &block)
                self.map_pairs(hash) do |k, v|
                    [block.call(k), v]
                end
            end
            
            ##
            # Emulates {#map_keys} on place. In fact, replaces old hash by 
            # new one.
            #
            # @param [Hash] hash  source hash
            # @param [Proc] block evaluating block
            # @return [Hash] new hash
            #
            
            def self.map_keys!(hash, &block)
                hash.replace(self.map_keys(hash, &block))
            end
            
            ##
            # Returns a new hash with the results of running block once for 
            # every pair in +hash+.
            #
            # @param [Hash] hash  source hash
            # @param [Proc] block evaluating block
            # @return [Hash] new hash
            # 
            
            def self.map_pairs(hash, &block)
                _new = self.recreate(hash)
                
                hash.each_pair do |k, v|
                    new_k, new_v = block.call(k, v)
                    _new[new_k] = new_v
                end
                
                return _new
            end
            
            ##
            # Recreates the hash, so creates empty one and assigns
            # the same default values.
            #
            # @param [Hash] hash  source hash
            # @return [Hash] new hash
            #
            
            def self.recreate(hash)
                self.create(hash.default, &hash.default_proc)
            end
            
            ##
            # Creates hash by setting default settings in one call.
            #
            # @param [Object] default  default value
            # @param [Hash] hash  initial values
            # @param [Proc] block  default block
            # @return [Hash] new hash
            #
            
            def self.create(default = nil, hash = nil, &block)
                if Ruby::Version >= "1.9"
                     if not hash.nil?
                         hash = hash.dup
                     else
                         hash = { }
                     end
                     
                     hash.default = default
                     hash.default_proc = block if not block.nil?
                     return hash
                 else
                     if not hash.nil?
                         hash = hash.dup
                     else
                         hash = { }
                     end
                     
                     if not block.nil?
                         _new = ::Hash::new(&block)
                         _new.update(hash) if not hash.empty?
                         hash = _new
                     else
                         hash.default = default
                     end
                     
                     return hash
                 end    
            end
            
            ##
            # Converts all +String+ keys to symbols. 
            #
            # @param [Hash] hash  source hash
            # @return [Hash] new hash
            #
            
            def self.keys_to_sym(hash)
                self.map_keys(hash) do |k|
                    if k.kind_of? ::String
                        k.to_sym 
                    else
                        k
                    end
                end
            end
            
            ##
            # Emulates {#keys_to_sym} on place. In fact, replaces old hash by 
            # new one.
            #
            # @param [Hash] hash  source hash
            # @return [Hash] new hash
            #
            
            def self.keys_to_sym!(hash)
                hash.replace(self.keys_to_sym(hash))
            end
            
            ##
            # Moves selected pairs outside the hash, so returns them.
            # Output hash has the same default settings.
            #
            # @param [Hash] hash  source hash
            # @param [Proc] block selecting block
            # @return [Hash] removed selected pairs
            #
            
            def self.remove!(hash, &block)
                result = self.recreate(hash)
                delete = [ ]
                
                hash.each_pair do |k, v|
                    if block.call(k, v)
                        result[k] = v
                        delete << k
                    end
                end
                
                delete.each do |k|
                    hash.delete(k)
                end
                
                return result
            end
            
            ##
            # Defines hash by setting the default value or an +Proc+ 
            # and content.
            #
            # @param [Hash] values  initial values
            # @param [Object] default  default value
            # @param [Proc] block  default block
            # @return [Hash] new hash
            #
            
            def self.define(values = { }, default = nil, &block) 
                hash = ::Hash[values]
                self.create(default, hash, &block)
            end
            
        end
        
    end
end
