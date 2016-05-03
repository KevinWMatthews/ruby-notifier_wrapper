#!/usr/bin/env ruby

class ExternalObject
  def method_that_yields(value)
    puts
    puts "In #{self.class.name}.#{__method__}!"
    puts "This should be overridden in the tests because"
    puts "we won't be able to control when and how this method yields."
    puts
    # yield(value)
  end
end
