#!/usr/bin/env ruby

require 'open4'

class Shell
  def execute(command)
    Open4.popen4(command)
  end
end
