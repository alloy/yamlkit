#!/usr/bin/env macruby

require File.expand_path('../test_helper', __FILE__)

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
    #p result
    
    assert_equal({ 'given' => 'Dorothy', 'family' => 'Gale' }, result['customer'])
    assert_equal 'Oz-Ware Purchase Invoice', result['receipt']
    
    #assert_instance_of Date, result['date']
    assert_equal '2007-08-06', result['date'].to_s
  end
end