require_relative './app.rb'

unless ENV['ISUCON5_DISABLE_LOGS'] == '1'
  require 'stackprof'
  require 'pathname'
  Pathname.new('/tmp/stackprof').mkpath

  use StackProf::Middleware, enabled: true,
                             mode: :cpu,
                             interval: 1000,
                             save_every: 5,
                             path: '/tmp/stackprof'
end

require 'gctools/oobgc'
use(GC::OOB::UnicornMiddleware) # in config.ru for unicorn

run Isucon5::WebApp
