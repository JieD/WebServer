module WebServer
  class Logger

    # Takes the absolute path to the log file, and any options
    # you may want to specify.  I include the option :echo to 
    # allow me to decide if I want my server to print out log
    # messages as they get generated
    def initialize(log_file_path, options={})
        @path=log_file_path
        @options={
            'yes'=>'',
            'no'=>'',
        }
        
        options.each{|k,v|
            k=k.to_s
            raise ArgumentError, "Unknown option: #{k}" unless @options.option?(k)
            @options[k]=v
        }
    end
    
    def [](options)
        options=options.to_s
        raise ArgumentError, "unknown option: #{options}" unless @options.option?(options)
        @options[options]
    end
    
    def [](options,val)
        options=options.to_s
        raise ArgumentError, "unknown option: #{options}" unless @options.option?(options)
        @options[options]=val
    end
    # Log a message using the information from Request and 
    # Response objects
    def log(request, response)
    end

    # Allow the consumer of this class to flush and close the 
    # log file
    def close
    end
  end
end
