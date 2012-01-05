require "non_blocking_lock/version"
require "non_blocking_lock/base"

if defined? ActiveRecord
  require "non_blocking_lock/mysql2_adapter"

  ActiveRecord::Base.class_eval do
    include NonBlockingLock
  end
end
