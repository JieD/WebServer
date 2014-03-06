module WebServer
    class Logger
        
        # Takes the absolute path to the log file, and any options
        # you may want to specify.  I include the option :echo to
        # allow me to decide if I want my server to print out log
        # messages as they get generated
        def initialize(log_file_path, options={})
            @path=log_file_path
            logfile=@path+"\\log.txt"
            $log=File.open(logfile, "w+")
        end
        
        # Log a message using the information from Request and
        # Response objects
        def log(request, response)
            
            log_message="\n\n==========\n#{response.message}"
            puts log_message
            $log.puts log_message unless $log==nil
            client=WebServer.accept
            @request=threads.gets
            log_message="#{client.peeraddr[2]} (#client.peeraddr[3]})\n"
            #log_message+=Time.now.localtime.strftime("%Y/%m%d ％H：％M：％S")
            log_message+="\n#{request}"
            
        end
        
        
        # Allow the consumer of this class to flush and close the
        # log file
        def close
            $log=File.close(logfile,"w+")
        end
    end
end
