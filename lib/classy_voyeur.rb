require_relative "classy_voyeur/version"

module ClassyVoyeur
  class Middleware

    # Meh, just cleanup when you are done
    def initialize
      at_exit { cleanup }
    end

    # Public: Directory where we should store the files
    def dir
      @dir ||= "/tmp/classy_voyeur"
    end

    # Public: Filename of where to store stats
    def filename
      "#{dir}/#{Process.pid}"
    end

    # Public: Make directory and Write to a file
    # str - String to write to file
    #
    # Raises RuntimeException if dir exists but is not a directory
    # Raises Errno if write permissions or other issues occur during file write
    # Returns str
    def write_to_file(str)
      if File.exists?(dir)
        unless File.directory?(dir)
          raise "#{dir} exists but is not a directory :/"
        end
      else
        FileUtils.mkdir_p(dir)
      end

      File.open(filename,"w") { |f| f.puts str }
      str
    end

    # Public: Removes the stats file associated with this process
    #
    def cleanup
      FileUtils.rm_f(filename)
    end

    # Public: Get the count of all the objects in this process's object space
    #
    # Returns a hash, the key is the object class, the value is the # of
    # instances of that class
    def object_stats
      hsh = ObjectSpace.count_objects
      hsh.default = 0

      ObjectSpace.each_object do |c|
        hsh[c] += 1
      end

      hsh
    end

    # Public: Make this a pretty HTML page
    #
    # stats - A hash/map/dictionary of object stats
    #
    # Returns a string
    def htmlize(stats)
      res = "<table><tr>"
      stats.each { |k,v| res << "<td>#{k}</td><td>#{v}</td>" }
      res << "</tr></table>"
    end

    # Public: Racky rack rack yall!
    #
    # env - Request params
    #
    # Returns an array
    def call(env)

      stats = object_stats

      write_to_file(stats.inspect)

      [200, {}, [htmlize(stats)]]
    end
  end
end
