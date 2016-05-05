#!/usr/bin/env ruby

class ObjectNeedsStub
  def get_a_value
    ExternalObject.a_method
  end
end

class ExternalObject
  def self.a_method
    666
  end
end
