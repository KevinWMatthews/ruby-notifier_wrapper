#!/usr/bin/env ruby

require 'minitest/autorun'
require 'spy'
require_relative '../src/shell.rb'

describe ShellWrapper do
  it 'can send a command using Open4' do
    command = 'sample shell command'
    shell = ShellWrapper.new
    spy = Spy.on(Open4, :popen4)

    shell.execute(command)

    spy.has_been_called_with?(command).must_be :==, true
  end
end
