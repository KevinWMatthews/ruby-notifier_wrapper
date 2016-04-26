require 'rake/testtask'

task default: [:test]

Rake::TestTask.new do |test|
  test.libs << "tests"
  test.test_files = FileList['test/test_*.rb']
end
