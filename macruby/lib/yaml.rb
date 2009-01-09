require 'date'

# require 'yaml/rubytypes'

module YAML
  class << self
    def load(string)
      parser { |p| p.readString(string) }
    end
    
    def load_file(file)
      parser { |p| p.readFile(file) }
    end
    
    private
    
    def parser
      parser = YKParser.alloc.init
      parser.castsNumericScalars = false # for now
      
      if yield(parser) == 1
        cast_elements(parser.parse.first)
      else
        raise "oops"
      end
    end
  end
  
  module Casting
    def cast_elements(enumerable)
      case enumerable
      when Hash then cast_hash_elements(enumerable)
      when Array then cast_array_elements(enumerable)
      end
    end
    
    def cast_hash_elements(hash)
      hash.each { |key, value| hash[key] = cast(value) }
      hash
    end
    
    def cast_array_elements(array)
      array.map { |element| cast(element) }
    end
    
    def cast(object)
      if object.is_a?(Hash)
        cast_hash_elements(object)
      elsif int = cast_integer(object)
        int
      elsif date = cast_date(object)
        date
      else
        object
      end
    end
    
    def cast_integer(object)
      int = object.to_i if object.respond_to?(:to_i)
      int if int && int.to_s == object
    end
    
    # Returns either a Date, DateTime object or nil if invalid.
    def cast_date(object)
      date = Date.parse(object)
      date.to_s == object ? date : DateTime.parse(object)
    rescue ArgumentError
      nil
    end
  end
  extend Casting
end