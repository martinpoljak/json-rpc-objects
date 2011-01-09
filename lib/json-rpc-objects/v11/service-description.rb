# encoding: utf-8
require "yajl/json_gem"
require "version"
require "addressable/uri"
require "json-rpc-objects/v11/service-procedure-description"
require "json-rpc-objects/generic"
require "hash-utils"

module JsonRpcObjects
    module V11
        class ServiceDescription < JsonRpcObjects::Generic::Object
        
            ##
            # Holds service name.
            #
            
            @name
            attr_accessor :name
            
            ##
            # Holds service identifier.
            #
            
            @id
            attr_accessor :id
            
            ##
            # Holds service version.
            #
            
            @version
            attr_accessor :version
            
            ##
            # Holds service summary.
            #
            
            @summary
            attr_accessor :summary
            
            ##
            # Holds service help URL.
            #
            
            @help
            attr_accessor :url
            
            ##
            # Holds service address.
            #
            
            @address
            attr_accessor :address
            
            ##
            # Holds procedure descriptions.
            #
            
            @procs
            attr_accessor :procs
        
            ##
            # Parses JSON-RPC string.
            #
            # @param [String] string with the JSON data
            # @return [V11::ServiceDescription] resultant description
            #
                        
            def self.parse(string)
                JsonRpcObjects::Generic::Object::parse(self, string)
            end

            ##
            # Creates new one.
            #
            # @param [Symbol] name name of the service
            # @param [String] id ID of the service (according 
            #   to specification it should be valid URI)
            # @param [Hash] opts additional options
            # @return [V11:ServiceDescription] new description object
            #
            
            def self.create(name, id, opts = { })
                data = {
                    :name => name,
                    :id => id
                }
                
                data.merge! opts
                return self::new(data)
            end
            
            ##
            # Checks correctness of the data.
            #
            
            def check!
                self.normalize!
                
                if not @name.kind_of? Symbol
                    raise Exception::new("Service name must be Symbol or convertable to Symbol.")
                end
                
                if not (@version.nil?) and ((@version.to_a.length < 2) or @version.prerelease?)
                    raise Exception::new("Version must be at least in <major>.<minor> format and must contain numbers only.")
                end
                
                if (not @procs.nil?) and ((not @procs.kind_of? Array) or (not @procs.all? { |v| v.kind_of? JsonRpcObjects::V11::ServiceProcedureDescription }))
                    raise Exception::new("If procs is defined, must be an Array of JsonRpcObjects::V11::ServiceProcedureDescription objects.")
                end
            end
            
            ##
            # Renders data to output hash.
            # @return [Hash] with data of description
            #
            
            def output
                self.check!
                
                data = {
                    :sdversion => :"1.0",
                    :name => @name.to_s,
                    :id => @id.to_s
                }
                
                if not @version.nil?
                    data[:version] = @version.to_s
                end
                
                if not @summary.nil?
                    data[:summary] = @summary
                end
                
                if not @help.nil?
                    data[:help] = @help.to_s
                end
                
                if not @address.nil?
                    data[:address] = @address.to_s
                end
                
                if not @procs.nil?
                    data[:procs] = @procs
                end
                
                return data
            end
            
            ##
            # Receives service procedure description objects.
            # @param [ServiceProcedureDescription] new service procedure description
            #
            
            def <<(value)
                if not value.kind_of? JsonRpcObjects::V11::ServiceProcedureDescription
                    raise Exception::new("ServiceProcedureDescription object expected.")
                end
                
                if @procs.nil?
                    @procs = [ ]
                end
                
                @procs << value
            end
                
                
                
            protected
            
            ##
            # Assigns request data.
            #
            
            def data=(value, mode = nil)            
                data = __convert_data(value, mode)
                
                @name = data[:name]
                @id = data[:id]
                @version = data[:version]
                @summary = data[:summary]
                @help = data[:help]
                @address = data[:address]
                @procs = data[:procs]
                
                if @procs.kind_of? Array
                    @procs = @procs.map { |v| JsonRpcObjects::V11::ServiceProcedureDescription::new(v) }
                end
            end
            
            ##
            # Converts request data to standard (defined) format.
            #
            
            def normalize!
                if @name.kind_of? String
                    @name = @name.to_sym
                end

                if not @id.kind_of? Addressable::URI
                    @id = Addressable::URI::parse(@id.to_s)
                end
                
                if (not @version.nil?) and (not @version.kind_of? Version)
                    @version = @version.to_s.to_version
                end
                
                if not @summary.nil?
                    @summary = @summary.to_s
                end
                
                if (not @help.nil?) and (not @help.kind_of? Addressable::URI)
                    @help = Addressable::URI::parse(@help.to_s)
                end
                
                if (not @address.nil?) and (not @address.kind_of? Addressable::URI)
                    @address = Addressable::URI::parse(@address.to_s)
                end
            end

                  
        end
    end
end
