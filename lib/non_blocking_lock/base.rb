

module NonBlockingLock
  class LockFailed < ActiveRecordError #:nodoc:
  end

  module ClassMethods
    # name - lock name
    # wait_time - default 1.second
    # &block to execute if lock obtained
    # return false if failed to get lock
    def non_blocking_lock( *args, &block )
      if connection.respond_to?( :non_blocking_lock )
        connection.non_blocking_lock( *args, &block )
      else
        raise ::LockFailed.new( "Not implemented." )
      end
    end

    # name - lock name
    # wait_time - default 1.second
    # &block to execute if lock obtained
    # raises exception if failed to get lock
    def non_blocking_lock!( *args, &block )
      unless non_blocking_lock( *args, &block )
        raise ::LockFailed.new( "Failed to obtain a lock." )
      end
    end
  end

  module InstanceMethods
    # name - lock name
    # wait_time - default 1.second
    # &block to execute if lock obtained
    # return false if failed to get lock
    def non_blocking_lock( *args, &block )
      string_id = "_#{self.class}_#{self.id}"
      if args.first.is_a? String
        args[0] += string_id
      else
        args.unshift(string_id)
      end
      self.class.non_blocking_lock( *args, &block )
    end
  end

  def self.included( base )
    base.extend( ClassMethods )
    base.class_eval do
      include ::NonBlockingLock::ClassMethods
      include ::NonBlockingLock::InstanceMethods
    end
  end
end
