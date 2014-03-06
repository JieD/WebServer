module WebServer
  module Response
    # Class to handle 400 responses
    class BadRequest < Base
      def initialize(resource, options={})
        super(resource,options)
      end
    end
  end
end
