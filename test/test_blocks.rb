#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/blocks.rb'

describe AnObject do
  it 'can store a value' do
    object = AnObject.new(value: 42)
    object.value.must_equal 42
  end

  it 'can process the value' do
    value = 42
    mock_behavior = MiniTest::Mock.new
    object = AnObject.new(value: value, behavior: mock_behavior)

    mock_behavior.expect(:process_value, :canned_response, [value])

    object.process_value

    mock_behavior.verify
  end
end
