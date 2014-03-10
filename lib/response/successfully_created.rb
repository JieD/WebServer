module WebServer
  module Response
    # Class to handle 201 responses
    class SuccessfullyCreated < Base
      def initialize(resource, options={})
        @code = 201
      end
    end
  end
end
