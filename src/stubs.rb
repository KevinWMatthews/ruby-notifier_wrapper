#!/usr/bin/env ruby

class ObjectNeedsStub
  def get_a_value
    ExternalObject.a_method
  end

  def do_something_to_a_file(filename)
    open(filename) do |file|
      text = file.read
      return 42 if (text.include? "text in file")
      66
    end
  end
end

class ExternalObject
  def self.a_method
    666
  end
end
