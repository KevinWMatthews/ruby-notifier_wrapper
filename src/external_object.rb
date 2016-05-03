#!/usr/bin/env ruby

class ExternalObject
  def method_that_yields(value)
    yield(value)
  end
end
