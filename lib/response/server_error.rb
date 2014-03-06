module WebServer
  module Response
    # Class to handle 500 errors
    class ServerError < Base
      def initialize(resource, options={})
        super(resource,options)
      end
    end
  end
end
