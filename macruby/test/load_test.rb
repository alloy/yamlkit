#!/usr/bin/env macruby

ROOT = File.expand_path("../../../", __FILE__)
framework File.join(ROOT, "build", "Release", "YAMLKit.framework")

require 'test/unit'
class Test::Unit::TestCase
  class << self
    def it(name, &block)
      define_method("test_#{name}", &block)
    end
  end
end

# These tests should probably move to the macruby part of rubyspec once we get to that point.
