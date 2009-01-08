#!/usr/bin/env macruby

ROOT = File.expand_path("../../../", __FILE__)
FIXTURES = File.expand_path("../fixtures", __FILE__)

# Build framework
Dir.chdir(ROOT) { system "rake YAMLKit:build" }

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
  
  it "loads a file with YAML.load_file" do
    yaml = YAML.load_file(fixture('very_simple.yaml'))
    expected = { 'title' => 'Escape of the Unicorn' }
    assert_equal expected, yaml
  end
end