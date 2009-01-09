#!/usr/bin/env macruby

require File.expand_path('../test_helper', __FILE__)

# These tests should probably move to the macruby part of rubyspec once we get to that point.

class TestYAMLCasting < Test::Unit::TestCase
  include YAML::Casting
  
  it "casts an Integer" do
    assert_equal 1, cast('1')
    assert_equal 1000_000, cast('1000000')
  end
  
  it "casts to nil if not a valid Integer" do
    assert_nil cast_integer('foo')
    assert_nil cast_integer('')
  end
  
  it "casts a Date" do
    assert_equal Date.parse('2007-08-06'), cast('2007-08-06')
  end
  
  it "casts a DateTime" do
    assert_equal DateTime.parse('2007-08-06 01:02:03'), cast('2007-08-06 01:02:03')
  end
  
  it "casts to nil if not a valid Date or DateTime" do
    assert_nil cast_date('2007-08')
    assert_nil cast_date('2008')
  end
end

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
    
    assert_equal 'Oz-Ware Purchase Invoice', result['receipt']
    assert_equal 1, result['id']
    assert_instance_of Date, result['date']
    assert_equal '2007-08-06', result['date'].to_s
    assert_equal({ 'given' => 'Dorothy', 'family' => 'Gale' }, result['customer'])
  end
end