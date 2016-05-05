#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/stubs.rb'

describe ObjectNeedsStub do
  it 'can stub a method of an external object' do
    object = ObjectNeedsStub.new
    ExternalObject.stub :a_method, :return_value do
      object.get_a_value.must_equal :return_value
    end
  end
end
