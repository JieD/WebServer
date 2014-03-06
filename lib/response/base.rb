require 'request'

module WebServer
    module Response
        # Provides the base functionality for all HTTP Responses
        # (This allows us to inherit basic functionality in derived responses
        # to handle response code specific behavior)
        class Base
            attr_reader :version, :code, :body, :headers, :status
            
            def initialize(resource,options={})
                @resource=resource
                @status=status
                @body=[]
                @headers=Response.default_headers.dup
                @code=200
                @mime_type=resource.mime_type
            end
            
            
            
            def to_s
                prepare_headers
               output="#{version} #{code} #{message}\n"
               output+=@headers.key.map do |header_key|
                   "#{header_key}: #{@headers[header_key]}\n"
                   #end join
               output+="\n#{body}"
               #send_data "HTTP/1.1 #{status}  #{RESPONSE_CODE}\r\n"
               #headers.each_pair do |name, value|
               #   send_data "#{name}: #{value}\r\n"
               #   end
               #send_data "\r\n"
               #body.each do |chunk|
               #   send_data chunk
               #   end
               #body.close
               #if body.respond_to? :close
               #end
            end
            
            def message
                #puts "#{@parser.http_method} #{@parser.request_path}"
                #puts "  " + @parser.headers.inspect
                RESPONSE_CODE[@code]
                env = {}
                @parser.headers.each_pair do |name, value|
                    name = 'HTTP_' + name.upcase.tr('-', '_')
                    env[name] = value
                    end
            
                env['REQUEST_METHOD'] = request.http_method
                
                env
            end
            
            
            
            def content_length
                
                return nil unless @code['content-length']
                len=@version,@code,@body['content-length'].slice(/\d+/)
                len.to_i
            end
        end
    end
  end
end
