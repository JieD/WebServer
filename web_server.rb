require 'socket'
Dir.glob('lib/**/*.rb').each do |file|
  require file
end

module WebServer
  class Server
    DEFAULT_PORT = 2468

    attr_accessor :conf, :mime

    def initialize(options={})
      # Set up WebServer's configuration files and logger here
      # Do any preparation necessary to allow threading multiple requests
      @conf = WebServer::Httpd_conf.new
      @mime = WebServer::Mimetypes.new
    end

    def start
        
      # Begin your 'infinite' loop, reading from the TCPServer, and
      # processing the requests as connections are made
      @logger.log_message="{SERVER} Starts on port #{conf.port}"

      #creating a thread when socket opened
      #create worker with socket
      while true 
        Thread.start(server.accept) do |client|
          WebServer::worker.new client, # logger
        Thread.current[:worker]=WebServer::Worker.new(client,self)
        end
      end
    end

    def server
      @server ||= TCPServer.open(@conf.port)
    end

    private
  end
end

WebServer::Server.new.start
