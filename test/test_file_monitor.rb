#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/file_monitor.rb'

describe FileMonitor do
  class NotifierAlwaysYields < INotify::Notifier
    attr_reader :mock
    def initialize(mock)
      @mock = mock
    end

    def watch(filename, action)
      yield
    end

    def process
      mock.process
    end

    def run
      mock.run
    end
  end

  class NotifierNeverYields < INotify::Notifier
    attr_reader :mock
    def initialize(mock)
      @mock = mock
    end

    def watch(filename, action)
    end

    def process
      mock.process
    end

    def run
      mock.run
    end
  end

  let(:filename) { 'sample_file.txt' }
  let(:mock_notifier) { MiniTest::Mock.new }
  let(:mock_behavior) { MiniTest::Mock.new }
  let(:mock_monitor) { NotifierAlwaysYields.new(mock_notifier) }
  let(:file_monitor) { FileMonitor.new(monitor: mock_monitor) }

  after do
    mock_notifier.verify
    mock_behavior.verify
  end

  it 'uses inotify by default' do
    file_monitor = FileMonitor.new
    file_monitor.monitor.must_be_instance_of(INotify::Notifier)
  end

  describe 'when blocking once' do
    it 'blocks until the file changes' do
      mock_notifier.expect(:process, nil, [])

      file_monitor.block_until_file_changes(filename)
    end

    it 'yields to a block when the file changes' do
      mock_notifier.expect(:process, nil, [])
      mock_behavior.expect(:on_file_changed, :not_using_return_value_yet, [])

      file_monitor.block_until_file_changes(filename) { mock_behavior.on_file_changed }
    end
  end

  describe 'when blocking until a string is added to the file' do
    let(:string) { "This is some text that will be added to a file." }

    it 'will not execute behavior until the string is found' do
      mock_monitor = NotifierNeverYields.new(mock_notifier)
      file_monitor = FileMonitor.new(monitor: mock_monitor)
      mock_notifier.expect(:run, nil, [])

      file_monitor.block_until_string_is_added_to_file(filename, string) { mock_behavior.on_file_changed }
    end

    it 'will yield to the block when the string is found' do
      mock_notifier.expect(:run, nil, [])
      mock_behavior.expect(:on_file_changed, :not_using_return_value_yet, [])

      file_monitor.block_until_string_is_added_to_file(filename, string) { mock_behavior.on_file_changed }
    end

    it 'unblocks but does nothing if no block is passed' do
      mock_notifier.expect(:run, nil, [])

      file_monitor.block_until_string_is_added_to_file(filename, string)
    end
  end
end
