#!/usr/bin/env macruby

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

# These tests should probably move to the macruby part of rubyspec once we get to that point.

class TestYAML < Test::Unit::TestCase
  it "loads a string with YAML.load" do
    assert_equal %w{ foo bar baz }, YAML.load("- foo\n- bar\n- baz")
  end
  
  it "loads a simple file with YAML.load_file" do
    result = YAML.load_file(fixture('very_simple.yaml'))
    expected = { 'title' => 'Escape of the Unicorn' }
    assert_equal expected, result
  end
  
  it "loads a more elaborate file with YAML.load_file" do
    result = YAML.load_file(fixture('moderate.yaml'))
    p result
    
    assert_equal({ 'given' => 'Dorothy', 'family' => 'Gale' }, result['customer'])
    assert_equal 'Oz-Ware Purchase Invoice', result['receipt']
    
    #assert_instance_of Date, result['date']
    assert_equal '2007-08-06', result['date'].to_s
  end
end