require 'socket'
Dir.glob('lib/**/*.rb').each do |file|
  require file
end

module WebServer
  class Server
    DEFAULT_PORT = 2468

    attr_accessor :conf, :mime

    def initialize(options={})
      
    end

    def start
        
      
    end

    def server
      @server ||= TCPServer.open(@conf.port)
    end

    private
  end
end

WebServer::Server.new.start
