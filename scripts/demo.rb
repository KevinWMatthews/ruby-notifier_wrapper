#!/usr/bin/env ruby

require_relative '../src/notifier_wrapper.rb'

notifier = NotifierWrapper.new
notifier.do_something_when_file_changes('sample_file.txt')
