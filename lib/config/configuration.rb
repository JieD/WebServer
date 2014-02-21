# This class should be used to encapuslate the functionality 
# necessary to open and parse configuration files. See
# HttpdConf and MimeTypes, both derived from this parent class.
module WebServer
  class Configuration
    attr_accessor :file

    def initialize(options={})	
      file_path = options.fetch(:configuration_directory) + "/" + options.fetch(:conf_file)
      raise ArgumentError unless File.exists?(file_path)
      @file = File.new(file_path, 'r')
    end
    
    def search_key(key)
      @file.each_line do |line|
        line.chomp!
        if line.empty? || line =~ /#(.*)/i
          next          
        else 
          break if line.match(/#{key}(\s*)("?)(.*)("?)/i)
        end   
      end
      $2 
    end
 
    def search_value(value)
    end

   # def next_line
    #  line = @file.readline.chomp
     # next_line() if line.empty?
   # end
  end
end
