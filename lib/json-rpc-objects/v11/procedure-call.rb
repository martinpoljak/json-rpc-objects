# encoding: utf-8
require "hash-utils"
require "json-rpc-objects/v10/request"
require "json-rpc-objects/generic"

##
# Main JSON-RPC Objects module.
#

module JsonRpcObjects

    ##
    # Module of JSON-RPC 1.1.
    #

    module V11
    
        ##
        # Procedure call (request) class.
        #
        
        class ProcedureCall < JsonRpcObjects::V10::Request

            ##
            # Holds JSON-RPC version specification.
            #
            
            VERSION = :"1.1"
            
            ##
            # Holds JSON-RPC version member identification.
            #
            
            VERSION_MEMBER = :version
            
            ##
            # Holds extensions.
            #
            
            @extensions
            attr_accessor :extensions
            
            ##
            # Holds keyword parameters.
            #
            
            @keyword_parameters
            attr_accessor :keyword_parameters
            
            ##
            # Checks correctness of the request data.
            #
            
            def check!
                super()
                
                if not @keyword_params.nil? and not @keyword_params.kind_of? Hash
                    raise Exception::new("Keyword params must be Hash.")
                end
            end
            
            ##
            # Converts back to JSON.
            #
            # @param [:wd, :alt] version specifies which version of 1.1
            #   to use -- either Working Draft (http://json-rpc.org/wd/JSON-RPC-1-1-WD-20060807.html)
            #   or Alternative (http://groups.google.com/group/json-rpc/web/json-rpc-1-1-alt)
            # @return [String]
            #
            
            def to_json(version = :wd)
                self.output(version).to_json
            end
            
            ##
            # Renders data to output hash.
            #
            # @param [:wd, :alt] version specifies which version of 1.1
            #   to use -- either Working Draft (http://json-rpc.org/wd/JSON-RPC-1-1-WD-20060807.html)
            #   or Alternative (http://groups.google.com/group/json-rpc/web/json-rpc-1-1-alt)
            # @return [Hash] with data of call
            #
            
            def output(version = :wd)
                self.check!
                data = {  
                    :method => @method.to_s
                }
                
                # Version
                __assign_version(data)
                
                # Params
                __assign_params(data, version)
                
                # ID
                if not @id.nil?
                    data[:id] = @id
                end
                
                data.merge! @extensions                
                return data
            end

            ##
            # Indicates, it's notification.
            # @return [Boolean] for JSON-RPC 1.1 returns always false.
            #

            def notification?
                false
            end
            
            ##
            # Handles method missing call for extensions.
            #
            # @param [Symbol] name of the method, setter if ends with '='
            # @param [Object] value for set
            # @return [Object] value set or get
            #
            
            def method_missing(name, *args)
                if name.to_s[-1].chr == ?=
                    self[name.to_s[0..-2]] = args.first
                else
                    self[name]
                end
            end
            
            ##
            # Handles array access as access for extensions too.
            #
            
            def [](name)
                @extensions[name.to_sym]
            end
            
            ##
            # Handles array set to extensions.
            #
            # @param [String] name of extension for return
            # @return [Object] value of extension member
            #
            
            def []=(name, value)
                @extensions[name.to_sym] = value
            end
            
            
            protected
            
            ##
            # Assigns request data.
            #

            def data=(value, mode = nil)
                data = __convert_data(value, mode)
                super(data, :converted)
                
                # Params
                __get_params(data)
                
                data.delete(:method)
                data.delete(:params)
                data.delete(:kwparams)
                data.delete(:id)
                
                __delete_version(data)
                
                # Extensions
                @extensions = data
            end            
            
            ##
            # Converts request data to standard (defined) format.
            #
            
            def normalize!
                __normalize_method
                
                if @extensions.nil?
                    @extensions = { }
                end
            end
            
            ##
            # Assignes the version specification.
            #
            
            def __assign_version(data)
                data[self.class::VERSION_MEMBER] = self.class::VERSION
            end
            

            ##
            # Gets params from input.
            #
            
            def __get_params(data)
            
                # If named arguments used, assigns keys as symbols
                #   but keeps numeric arguments as integers

                if @params.kind_of? Hash
                    @params = @params.dup
                    @keyword_params = @params.remove! { |k, v| not k.numeric? }
                    @params = @params.sort_by { |i| i[0].to_i }.map { |i| i[1] }
                else
                    @keyword_params = { }
                end
                
                # For alternative specification merges with 'kwparams'
                #   property.
                
                if data.include? :kwparams
                   @keyword_params.merge! data[:kwparams]
                end
                
                @keyword_params.map_keys! { |k| k.to_sym }
                
            end
            
            ##
            # Assigns the parameters settings.
            #
            
            def __assign_params(data, version = :wd)
                if version == :alt
                    if not @params.nil? and not @params.empty?
                        data[:params] = @params
                    end
                    if not @keyword_params.nil? and not @keyword_params.empty?
                        data[:kwparams] = @keyword_params
                    end
                else
                    params = { }
                    
                    if not @params.nil?
                        @params.each_index do |i|
                            params[i.to_s.to_sym] = @params[i]
                        end
                    end
                    if not @keyword_params.nil?
                        params.merge! @keyword_params
                    end
                    
                    data[:params] = params
                end
            end
                        
            ##
            # Checks params data.
            #
            
            def __check_params
                if not @params.nil? and not @params.kind_of? Array
                    raise Exception::new("Params must be Array.")
                end
            end
            
            ##
            # Removes the version specification.
            #
            
            def __delete_version(data)
                data.delete(self.class::VERSION_MEMBER)
            end
                        
        end
    end
end

