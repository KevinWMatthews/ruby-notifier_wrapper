#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/stubs.rb'

describe ObjectNeedsStub do
  class StubOpenMethod < ObjectNeedsStub
    def open filename
      yield StringIO.new("text in file")
    end
  end

  let(:object) { ObjectNeedsStub.new }

  it 'can stub a method of an external object' do
    ExternalObject.stub :a_method, :return_value do
      object.get_a_value.must_equal :return_value
    end
  end

  it 'can handle a block' do
    object = StubOpenMethod.new
    object.do_something_to_a_file("filename").must_equal 42
  end
end
