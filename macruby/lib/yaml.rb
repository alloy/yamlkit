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
      if yield(parser) == 1
        parser.parse.first
      else
        raise "oops"
      end
    end
  end
end