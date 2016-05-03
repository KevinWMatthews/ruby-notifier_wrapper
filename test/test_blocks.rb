#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/blocks.rb'

describe AnObject do
  it 'can store a value' do
    object = AnObject.new(value: 42)
    object.value.must_equal 42
  end
end
