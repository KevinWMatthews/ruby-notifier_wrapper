#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/file_monitor.rb'

describe FileMonitor do
  class TestNotifier < INotify::Notifier
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
  end

  it 'uses inotify by default' do
    wrapper = FileMonitor.new
    wrapper.monitor.must_be_instance_of(INotify::Notifier)
  end

  describe 'when blocking once' do
    let(:filename) { 'sample_file.txt' }
    let(:mock_notifier) { MiniTest::Mock.new }
    let(:mock_behavior) { MiniTest::Mock.new }
    let(:mock_monitor) { TestNotifier.new(mock_notifier) }
    let(:wrapper) { FileMonitor.new(monitor: mock_monitor) }

    after do
      mock_notifier.verify
      mock_behavior.verify
    end

    it 'blocks until the file changes' do
      mock_notifier.expect(:process, nil, [])

      wrapper.block_until_file_changes(filename)
    end

    it 'yields to a block when the file changes' do
      mock_behavior.expect(:on_file_changed, :not_using_return_value_yet, [])
      mock_notifier.expect(:process, nil, [])

      wrapper.block_until_file_changes(filename) { mock_behavior.on_file_changed }
    end
  end

  describe 'when blocking indefinitely' do
    it 'can block until a string match is detected' do
      skip
    end
  end
end
