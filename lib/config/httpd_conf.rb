require_relative 'configuration'

# Parses, stores, and exposes the values from the httpd.conf file
module WebServer
  class HttpdConf < Configuration
    def initialize(options={})
      super(options)
    end

    # Returns the value of the ServerRoot
    def server_root 
      search_key("ServerRoot")
    end

    # Returns the value of the DocumentRoot
    def document_root
      search_key("DocumentRoot")
    end

    # Returns the directory index file
    def directory_index
      search_key("DirectoryIndex")
    end

    # Returns the *integer* value of Listen
    def port
      search_key("Listen")
    end

    # Returns the value of LogFile
    def log_file
      search_key("LogFile")
    end

    # Returns an array of ScriptAlias directories
    def script_aliases
      search_key("ScriptAliases")
    end

    # Returns the aliased path for a given ScriptAlias directory
    def script_alias_path(path)
    end

    # Returns an array of Alias directories
    def aliases
    end

    # Returns the aliased path for a given Alias directory
    def alias_path(path)
    end
  end
end
