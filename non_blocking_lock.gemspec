# -*- encoding: utf-8 -*-
require File.expand_path('../lib/non_blocking_lock/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors        = ["Ryan Funduk"]
  gem.email          = ["ryan.funduk@gmail.com"]
  gem.description    = %q{A non_blocking_lock implementation for ActiveRecord adapters (well, just Mysql2 right now).}
  gem.summary        = %q{}
  gem.homepage       = "http://github.com/rfunduk/non_blocking_lock"

  gem.executables    = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files          = `git ls-files`.split("\n")
  gem.test_files     = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name           = "non_blocking_lock"
  gem.require_paths  = ["lib"]
  gem.version        = NonBlockingLock::VERSION
end
