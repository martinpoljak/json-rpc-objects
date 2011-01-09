# encoding: utf-8
require "addressable/uri"
require "multitype-introspection"
require "types"
require "hash-utils/array"
require "json-rpc-objects/v11/procedure-parameter-description"
require "json-rpc-objects/generic"

module JsonRpcObjects
    module V11
        class ServiceProcedureDescription < JsonRpcObjects::Generic::Object
        
            ##
            # Holds procedure name.
            #
            
            @name
            attr_accessor :name
            
            ##
            # Holds procedure summary.
            #
            
            @summary
            attr_accessor :summary
            
            ##
            # Holds procedure help URL.
            #
            
            @help
            attr_accessor :url
            
            ##
            # Indicates procedure idempotency.
            #
            
            @idempotent
            attr_accessor :idempotent
            
            ##
            # Holds procedure params specification.
            #
            
            @params
            attr_accessor :params
            
            ##
            # Holds procedure return value specification.
            #
            
            @return
            attr_accessor :return

            ##
            # Parses JSON-RPC string.
            #
            # @param [String] string with the JSON data
            # @return [V11::ServiceProcedureDescription] resultant description
            #
                        
            def self.parse(string)
                JsonRpcObjects::Generic::Object::parse(self, string)
            end

            ##
            # Creates new one.
            #
            # @param [Symbol] name name of the procedure
            # @param [Hash] opts additional options
            # @return [V11:ServiceProcedureDescription] new description object
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
                    raise Exception::new("Procedure name must be Symbol or convertable to Symbol.")
                end

                if (not @params.nil?) and ((not @params.kind_of? Array) or (not @params.all? { |v| v.kind_of? JsonRpcObjects::V11::ProcedureParameterDescription }))
                    raise Exception::new("If params is defined, must be an Array of JsonRpcObjects::V11::ProcedureParameterDescription objects.")
                end
                
                if (not @return.nil?) and (not @return.kind_of? JsonRpcObjects::V11::ProcedureParameterDescription)
                    raise Exception::new("If return is defined, must be set to JsonRpcObjects::V11::ProcedureParameterDescription object.")
                end

                if (not @idempotent.nil?) and (not @idempotent.type_of? Boolean)
                    raise Exception::new("If idempotent is defined, must be boolean.")
                end
            end
            
            ##
            # Renders data to output hash.
            # @return [Hash] with data of description
            #
            
            def output
                self.check!
                data = { :name => @name.to_s }
                
                if not @summary.nil?
                    data[:summary] = @summary
                end
                
                if not @help.nil?
                    data[:help] = @help.to_s
                end
                
                if not @idempotent.nil?
                    data[:idempotent] = @idempotent
                end
                
                if not @params.nil?
                    data[:params] = @params
                end

                if not @return.nil?
                    data[:return] = @return
                end
                
                return data
            end
            
            ##
            # Receives service procedure description objects.
            #
            # @param [ProcedureParameterDescription] value with new 
            #   service procedure descriptor
            #
            
            def <<(value)
                if not value.kind_of? JsonRpcObjects::V11::ProcedureParameterDescription
                    raise Exception::new("ProcedureParameterDescription object expected.")
                end
                
                if @params.nil?
                    @params = [ ]
                end
                
                @params << value
            end
                                
                
                
            protected
            
            ##
            # Assigns request data.
            #
            
            def data=(value, mode = nil)            
                data = __convert_data(value, mode)
                
                @name = data[:name]
                @summary = data[:summary]
                @help = data[:help]
                @idempotent = data[:idempotent]
                @params = data[:params]
                @return = data[:return]
                
                if @params.kind_of? Array
                    @params = @params.map { |v| JsonRpcObjects::V11::ProcedureParameterDescription::new(v) }
                end
                
                if @return.kind_of? Hash
                    @return = JsonRpcObjects::V11::ProcedureParameterDescription::new(@return)
                end
            end
            
            ##
            # Converts request data to standard (defined) format.
            #
            
            def normalize!
                if @name.kind_of? String
                    @name = @name.to_sym
                end
                
                if not @summary.nil?
                    @summary = @summary.to_s
                end
                
                if (not @help.nil?) and (not @help.kind_of? Addressable::URI)
                    @help = Addressable::URI::parse(@help.to_s)
                end
            end

        end
    end
end
