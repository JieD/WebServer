require_relative 'request'
require_relative 'response'

# This class will be executed in the context of a thread, and
# should instantiate a Request from the client (socket), perform
# any logging, and issue the Response to the client.
module WebServer
  class Worker
    # Takes a reference to the client socket and the logger object
    def initialize(csocket, server)
        @client=csocket
        @server=server
        process_request
    end

    # Processes the request
    def process_request
        #begin
         #   @server,logger,log(request,response)
       # rescue Exception=>error
       # @server,logger,log(request,error_response)
#        ensure
 #       @client,
  #        puts response
   #     @client,
         # close
       # end
    end
  end
end
