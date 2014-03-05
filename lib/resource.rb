module WebServer
  class Resource
    attr_reader :request, :conf, :mimes

    def initialize(request, httpd_conf, mimes)
      @request = request
      @conf = httpd_conf
      @mimes = mimes
    end
   
    # check uri of request to resolve aliased and script aliased issue
    #
    # note that directory_index is always append last to the absolute path, if the path is not script_aliased
    # if the path is to a directory, need some file to access the directory. if no file is given, need a default file. httpd_conf file specifies which default file to use.
    def resolve
      uri = @request.uri
      uri.match /(.*)\/(.*)/i
      absolute_path = "#{@conf.document_root}"
      
      if aliased? # need to check aliased? first due to spec test
        # puts $1, $2
        # print "aliased: true\n"
        # return format: 
        # document_root + alias path + file + directory_index
        absolute_path += "#{@conf.alias_path($1)}/#{$2}/#{@conf.directory_index}"
      else
        if script_aliased?
          # puts $1, $2
          # print "script_aliased: true\n"
          # return format: document_root + script alias path + file
           absolute_path += "#{@conf.script_alias_path($1)}/#{$2}"
        else 
          # puts $1, $2 
          # print "non_aliased: true\n" 
          # return format: document_root + uri + directory_indes
          absolute_path += "#{uri}/#{@conf.directory_index}"
        end
      end
    end

    def script_aliased?
      @request.uri.match /(.*)\/(.*)/i
      @conf.script_aliases.include? $1 
    end
 
    def aliased?
      @request.uri.match /(.*)\/(.*)/i
      @conf.aliases.include? $1  
    end
   
    def read_htaccess path, hash
      File.open(path).each do |line| 
        array = line.split
        hash.store array[0], array[1]
      end
      puts hash
    end
    # check whether the requested resource is in protected directory
    #
    # the way to check is to see whether there is a .htaccess file in the directory where the requested resource locates (protected by .htaccess file)
    # if AuthType: Basic, protected
    # if AuthType: None, not protected
    # note in a directory, the child .htaccess file overrides its parents' .htaccess file, if it exists. If not, inherites its parents' .htaccess file. 
    #------------------- .htaccess file format-------------------------
    # AuthType Basic
    # AuthName auth-domain 
    # AuthUserFile file-path 
    # Require entity-name 
    #
    # AuthName sets the name of the authorization realm for a directory. This realm is given to the client so that the user knows which username and password to send. The string provided for the AuthName is what will appear in the password dialog provided by most browsers
    # AuthUserFile sets the name of a text file containing the list of users and passwords for authentication. Each line of the user file contains a username followed by a colon, followed by the encrypted password.
    # Require tests whether an authenticated user is authorized by an authorization provider
    # -------------- end of .htaccess file format----------------------
    # checking strategy:
    # for any given uri, start from the document root directory, walking all the way down to the directory that the uri specifies. recursively check whether the .htaccess file exists, parse the file to a hash, and update the hash. (this enables the children override parents)
    def protected?
      auth_hash = Hash.new
      ac_file = @conf.access_file_name
      dir = File.dirname resolve
      puts dir
      path_array = dir[1..-1].split /\//
      parent_dir = "/" 
      path_array.each do |e| 
        puts parent_dir += e + "/"
        if File.exists? ac_file_path = "#{parent_dir}#{ac_file}"
           read_htaccess ac_file_path, auth_hash
        end
      end
      # File.exists? "#{@conf.document_root}/protected/#{@conf.access_file_name}"
      auth_hash[AuthType] == "Basic" if !auth_hash.empty?
    end

    def authorized?
      if this.protected?
        username = @request.params[username]
        password = @request.params[password]
      else
        
      end
    end
 
    def authorized? info
      info[username] == "valid_name" && info[password] == "valid_pwd"
    end

  end
end
