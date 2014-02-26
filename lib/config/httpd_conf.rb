require_relative 'configuration'

# Parses, stores, and exposes the values from the httpd.conf file
module WebServer
  class HttpdConf < Configuration
    attr_accessor :conf
 
    def initialize(options={})
      super(options)
      parse_file()
    end

    def parse_file()
      @conf = Hash.new
      populate(@conf)
    end

    # Returns the value of the ServerRoot
    def server_root 
      @conf["ServerRoot"]
    end

    # Returns the value of the DocumentRoot
    def document_root
      @conf["DocumentRoot"]
    end

    # Returns the directory index file
    def directory_index
      @conf["DirectoryIndex"]
    end

    # Returns the *integer* value of Listen
    def port
      @conf["Listen"].to_i
    end

    # Returns the value of LogFile
    def log_file
      @conf["LogFile"]
    end

    # Returns the name of the AccessFile 
    def access_file_name
      @conf["AccessFileName"]
    end

    # Returns an array of ScriptAlias directories
    def script_aliases
      @conf["ScriptAlias"].keys
    end

    # Returns the aliased path for a given ScriptAlias directory
    def script_alias_path(path)
      @conf["ScriptAlias"][path]
    end

    # Returns an array of Alias directories
    def aliases
      @conf["Alias"].keys
    end

    # Returns the aliased path for a given Alias directory
    def alias_path(path)
      @conf["Alias"][path]
    end
  end
end
