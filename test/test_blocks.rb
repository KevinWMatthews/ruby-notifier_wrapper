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

describe ValueNotChanged do
  it 'leaves the argument unchanged' do
    value = 42
    behavior = ValueNotChanged.new
    behavior.process_value(value).must_equal value
  end
end

describe ValueDoubled do
  it 'doubles the argument' do
    value = 42
    behavior = ValueDoubled.new
    behavior.process_value(value).must_equal value * 2
  end
end
