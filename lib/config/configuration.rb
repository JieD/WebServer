# This class should be used to encapuslate the functionality 
# necessary to open and parse configuration files. See
# HttpdConf and MimeTypes, both derived from this parent class.
module WebServer
  class Configuration
    attr_accessor :file

    # parse options to get the file path and check it
    def initialize(options={})	
      file_path = get_path(options)
      raise ArgumentError unless File.exists?(file_path)
      @file = File.new(file_path, 'r')
    end
    
    # Parse options to obtain the full directory for the file
    # Since not knowing keys of options (type hash), need to use iterator 
    # to obtain the value and format it
    # cannot use the following line since not knowing the key: 
    # file_path = options.fetch(:configuration_directory) + "/" + options.fetch(:conf_file)
    def get_path(options)
      path = ""
      options.each_key {|key| path += options[key] + "/"}
      path.chop!
    end

    # read the file data into hash
    # 3 steps:
    # 1. discard empty line and comments
    # 2. extract the information in key-value format and store it in an array
    # 3. store the data in the array into the hash
    def populate(hash)
      @file.each_line do |line|
        line.chomp!
       # puts line
        if line.empty? || line =~ /(\s*)#(.*)/i
          next
        else
          info = extract_info(line)
          store info, hash
        end
      end
    end
    
    # store the passed in string in key-value format in an array, clean the value if needed
    def extract_info(line)
      array = line.split
      key = array.first
      value = array.drop(1)
      value.each{|e| e.delete! "\""}
      return key, value
    end
    
    # store the information into the hash
    # need to check whether the key is existed to prevent losing data
    # the only time the key existed already is for alias type info. need to create a new hash to store the duplicated key data
    def store(info, hash)
      key = info.first
      value = info.last
      if value.length == 2
        unless hash.has_key? key
         sub_hash = Hash.new # create a new hash for alias data
          hash.store(key, sub_hash)
        end
        sub_key = value.first
        sub_value = value.last
        sub_hash = hash[key]
        sub_hash.store(sub_key, sub_value) 
      else  # non-alias data, note value is an array
        hash.store(key, value.first)
      end 
    end
  end
end
