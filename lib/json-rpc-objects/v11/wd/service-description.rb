# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "addressable/uri"
require "json-rpc-objects/v11/wd/service-procedure-description"
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
            # Service description object class.
            #
            
            class ServiceDescription < JsonRpcObjects::Generic::Object
            
                ##
                # Holds link to its version module.
                #
                
                VERSION = JsonRpcObjects::V11::WD
                            
                ##
                # Indicates the service procedure description class.
                #
                
                PROCEDURE_DESCRIPTION_CLASS = JsonRpcObjects::V11::WD::ServiceProcedureDescription
                
                ##
                # Holds version number matcher.
                #
                
                VERSION_MATCHER = /^\d+\.\d+/
            
                ##
                # Holds service name.
                # @return [Symbol]
                #
                
                attr_accessor :name
                @name
                
                ##
                # Holds service identifier.
                # @return [Addressable::URI]
                #
                
                attr_accessor :id
                @id
                
                ##
                # Holds service version.
                # @return [String]
                #
                
                attr_accessor :version
                @version
                
                ##
                # Holds service summary.
                # @return [String]
                #
                
                attr_accessor :summary
                @summary
                
                ##
                # Holds service help URL.
                # @return [Addressable::URI]
                #
                
                attr_accessor :url
                @help
                
                ##
                # Holds service address.
                # @return [Addressable::URI]
                #
                
                attr_accessor :address
                @address
                
                ##
                # Holds procedure descriptions.
                # @return [Array]
                #
                
                attr_accessor :procs
                @procs
            
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

                    if not @name.kind_of?(Symbol)
                        raise Exception::new("Service name must be Symbol or convertable to Symbol.")
                    end

                    if not (@version.nil?) and not @version.match(self.class::VERSION_MATCHER)
                        raise Exception::new("Version must be at least in <major>.<minor> format and must contain numbers only.")
                    end

                    if (not @procs.nil?)
                        if (not @procs.kind_of?(Array)) or (not @procs.all? { |v| v.kind_of? self.class::PROCEDURE_DESCRIPTION_CLASS })
                            raise Exception::new("If procs is defined, must be an Array of " << self.class::PROCEDURE_DESCRIPTION_CLASS.name << " objects.")
                        end

                        if @procs.kind_of?(Array)
                            @procs.each { |proc| proc.check! }
                        end
                    end
                end
                
                ##
                # Renders data to output hash.
                # @return [Hash] with data of description
                #
                
                def output
                    self.check!
                    
                    data = {
                        "sdversion" => "1.0",
                        "name" => @name.to_s,
                        "id" => @id.to_s
                    }
                    
                    if not @version.nil?
                        data["version"] = @version
                    end
                    
                    if not @summary.nil?
                        data["summary"] = @summary
                    end
                    
                    if not @help.nil?
                        data["help"] = @help.to_s
                    end
                    
                    if not @address.nil?
                        data["address"] = @address.to_s
                    end
                    
                    if not @procs.nil?
                        data["procs"] = @procs.map { |i| i.output }
                    end
                    
                    return data
                end
                
                ##
                # Receives service procedure description objects.
                # @param [ServiceProcedureDescription] new service procedure description
                #
                
                def <<(value)
                    if not value.kind_of? self.class::PROCEDURE_DESCRIPTION_CLASS
                        raise Exception::new(self.class::PROCEDURE_DESCRIPTION_CLASS.name.dup << " object expected.")
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

                    if @procs.kind_of?(Array)
                        @procs = @procs.map { |v| self.class::PROCEDURE_DESCRIPTION_CLASS::new(v) }
                    end
                end
                
                ##
                # Converts request data to standard (defined) format.
                #
                
                def normalize!
                    if @name.string?
                        @name = @name.to_sym
                    end

                    if not @id.kind_of? Addressable::URI
                        @id = Addressable::URI::parse(@id.to_s)
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
end
