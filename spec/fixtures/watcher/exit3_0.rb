#!/usr/bin/env ruby
require 'docker_toolkit'

STDOUT.sync = true
STDERR.sync = true

# first must be externaly terminated by signal and second is terminated(code 0)
# code 0
DockerToolkit::Watcher.new.exec do |w|
  pr = w.add 'terminator.rb', '--sleep', '12', '--term-code', '0'
  w.add 'terminator.rb', '--sleep', '14', '--term-code', '0'

  Thread.new do
    sleep 3
    ::Process.kill 'TERM', pr.pid
  end
end
