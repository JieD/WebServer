module WebServer
  module Response
    # Class to handle 403 responses
    class Forbidden < Base
      def initialize(resource, options={})
        super(resource,options)
      end
    end
  end
end
