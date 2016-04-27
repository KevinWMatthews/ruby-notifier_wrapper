#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/notifier_wrapper.rb'

describe NotifierWrapper do
  it 'uses inotify by default' do
    wrapper = NotifierWrapper.new
    wrapper.notifier.must_be_instance_of(INotify::Notifier)
  end

  it 'can detect a change to a file' do
    file_to_watch = 'sample_file.txt'
    mock_notifier = MiniTest::Mock.new

    mock_notifier.expect(:watch, :figure_out_what_to_return, [file_to_watch, :modify])
    mock_notifier.expect(:process, nil)

    wrapper = NotifierWrapper.new(notifier: mock_notifier)

    wrapper.do_something_when_file_changes(file_to_watch)

    mock_notifier.verify
  end
end
