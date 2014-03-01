require 'socket'
Dir.glob('lib/**/*.rb').each do |file|
  require file
end

module WebServer
  class Server
    DEFAULT_PORT = 2468

    def initialize(threads,logger,options={})
      # Set up WebServer's configuration files and logger here
      # Do any preparation necessary to allow threading multiple requests
      @threads=threads
      @logger=logger
      @running=true
      Thread.abort_on_exception=true
      Kernel.trap("INT")do
          shutdown
          end
    end

    def start
        
      # Begin your 'infinite' loop, reading from the TCPServer, and
      # processing the requests as connections are made
      @logger.log_message="{SERVER} Starts on port #{conf.port}"
      #while true
      #creating a thread when socket opened
      #create worker with socket
      while @running
          begin
              @threads <<Thread.start(server.accept)do|client|
                  Thread.current[:worker]=WebServer::Worker.new(client,self)
          end
         rescue StandardError =>error
         server_error(error)
         end
        
         cleanup_threads
    end

    private
  end
end

WebServer::Server.new.start
