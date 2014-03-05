require_relative 'request'
require_relative 'response'

# This class will be executed in the context of a thread, and
# should instantiate a Request from the client (socket), perform
# any logging, and issue the Response to the client.
module WebServer
  class Worker
    # Takes a reference to the client socket and the logger object

    def initialize(client, logger)
        @client = client 
        @logger = logger
        # process_request
    end

    # Processes the request
    def process_request
      WebServer::Request.new client
    end
  end
end
