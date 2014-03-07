# HttpdConf and MimeTypes, both derived from this parent class.
module WebServer
  class Configuration
    attr_accessor :file, :hash
    # @@no = 0

    # parse options to get the file path and check it
    def initialize(options={})	
      # @@no += 1
      @hash = Hash.new
      file_path = get_path(options)
      raise ArgumentError unless File.exists?(file_path)
      puts "--- #{file_path}"
      @file = File.new(file_path, 'r')
      # print @@no, " #{@file == nil}\n"
      parse_file
    end
  
    # Parse options to obtain the full directory for the file
    # Since not knowing keys of options (type hash), need to use iterator 
    # to obtain the value and format it
    # cannot use the following line since not knowing the key: 
    # file_path = options.fetch(:configuration_directory) + "/" + options.fetch(:conf_file)
    def get_path(options)
      path = ""
      options.each_key {|key| path += options[key] + "/"}
      path.chop!  # chop the last '/'
    end

    # read the file data into hash
    # 3 steps:
    # 1. discard empty line and comments
    # 2. extract the information in key-value format and store it in an array
    # 3. store the data in the array into the hash
    def parse_file()
      unless @file.nil?
        @file.each do |line|
          line.chomp!
          # puts line
          if line.empty? || line =~ /(\s*)#(.*)/i
            next
          else
            info = extract_info(line)
            store info
          end
        end
      end
    end
    
    # extract the information from the passed in string
    # split the string into an array. the first element should be the key and the rest are the value (to store in the hash)
    # clean the value if needed.
    # return a new array with two elements: key and value 
    def extract_info(line)
      array = line.split
      key = array.first
      value = array.drop(1)   # drop the first element
      value.each{|e| e.delete! "\""}
      return key, value
    end

    # store the information into the hash
    # needs to be override in subclasses   
    def store(info)
    end
  end
end
