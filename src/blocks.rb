#!/usr/bin/env ruby

class AnObject
  attr_reader :value, :behavior
  def initialize(value: nil, behavior: nil)
    @value = value
    @behavior = behavior
  end

  def process_value
    behavior.process_value(value)
  end
end
