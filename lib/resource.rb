module WebServer
  class Resource
    attr_reader :request, :conf, :mimes

    def initialize(request, httpd_conf, mimes)
      @request = request
      @conf = httpd_conf
      @mimes = mimes
    end
   
    # check uri of request to resolve aliased and script aliased issue
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
  end
end
