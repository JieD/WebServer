module WebServer
  module Response
    # Class to handle 403 responses
    class Forbidden < Base
      def initialize(resource, options={})
        @code = 403
      end
    end
  end
end
