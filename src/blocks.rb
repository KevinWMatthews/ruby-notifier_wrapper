#!/usr/bin/env ruby

class AnObject
  attr_reader :value, :behavior, :external_class
  def initialize(value: nil, behavior: nil, external_class: ExternalObject.new)
    @value = value
    @behavior = behavior
    @external_class = external_class
  end

  def process_value
    external_class.method_that_yields(value) do |block_argument|
      behavior.process_value(block_argument)
    end
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

class ExternalObject
  def method_that_yields(value)
    yield(value)
  end
end
