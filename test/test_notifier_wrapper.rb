#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/notifier_wrapper.rb'

describe NotifierWrapper do
  class TestNotifier < INotify::Notifier
    def watch(filename, action)
      yield
    end
  end

  it 'uses inotify by default' do
    wrapper = NotifierWrapper.new
    wrapper.notifier.must_be_instance_of(INotify::Notifier)
  end

  it 'can detect a change to a file' do
    filename = 'sample_file.txt'
    mock_behavior = MiniTest::Mock.new
    wrapper = NotifierWrapper.new(notifier: TestNotifier.new, behavior: mock_behavior)

    mock_behavior.expect(:on_file_changed, :not_using_return_value_yet, [])

    wrapper.set_action_on_file_changed(filename)

    mock_behavior.verify
  end

  it 'blocks until the first time the file changes' do
    mock_notifier = MiniTest::Mock.new
    wrapper = NotifierWrapper.new(notifier: mock_notifier)

    mock_notifier.expect(:process, nil, [])

    wrapper.block_until_file_changes

    mock_notifier.verify
  end
end
