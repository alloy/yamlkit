ROOT = File.expand_path("../../../", __FILE__)
FIXTURES = File.expand_path("../fixtures", __FILE__)

# Build framework
Dir.chdir(ROOT) do
  exit(1) unless system("rake YAMLKit:build")
end

framework File.join(ROOT, "build", "Release", "YAMLKit.framework")
require File.join(ROOT, 'macruby', 'lib', 'yaml')

require 'test/unit'
class Test::Unit::TestCase
  class << self
    def it(name, &block)
      define_method("test_#{name}", &block)
    end
  end
  
  private
  
  def fixture(name)
    File.join(FIXTURES, name)
  end
end