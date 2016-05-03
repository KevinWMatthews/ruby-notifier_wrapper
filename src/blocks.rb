#!/usr/bin/env ruby

class AnObject
  attr_reader :value
  def initialize(value: nil)
    @value = value
  end
end
