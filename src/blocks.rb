#!/usr/bin/env ruby

class AnObject
  attr_reader :value, :behavior
  def initialize(value: nil, behavior: nil)
    @value = value
    @behavior = behavior
  end

  def process_value
    method_that_yields do |block_argument|
      behavior.process_value(block_argument)
    end
  end

  def method_that_yields
    yield(value)
  end
end

class ValueNotChanged
  def process_value(value)
    value
  end
end

class ValueDoubled
  def process_value(value)
    value * 2
  end
end
