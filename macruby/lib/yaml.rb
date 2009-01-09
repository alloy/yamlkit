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
      elsif numeric = cast_numeric(object)
        numeric
      elsif date = cast_date(object)
        date
      elsif !(bool = cast_bool(object)).nil?
        bool
      else
        object
      end
    end
    
    def cast_numeric(object)
      return nil unless object.respond_to?(:to_i)
      if (numeric = object.to_i).to_s == object
        numeric
      elsif (numeric = object.to_f).to_s == object
        numeric
      end
    end
    
    def cast_bool(object)
      if object == 'true'
        true
      elsif object == 'false'
        false
      end
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