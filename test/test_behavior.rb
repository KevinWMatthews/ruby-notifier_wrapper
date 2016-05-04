#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/behavior.rb'

describe DoNothing do
  it 'does nothing' do
    behavior = DoNothing.new
    behavior.on_file_changed
  end
end
