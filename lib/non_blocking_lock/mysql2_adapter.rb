require 'active_record/connection_adapters/abstract_mysql_adapter'

module ActiveRecord
  module ConnectionAdapters
    class Mysql2Adapter < AbstractMysqlAdapter
      # name - lock name
      # wait_time - default 1.second
      # &block to execute if lock obtained
      # return false if failed to get lock
      def non_blocking_lock( name, wait_time=1.0 )
        raise ArgumentError.new("name can't be empty") if name.blank?
        raise ArgumentError.new("wait_time can't be less then 0") if wait_time.to_f <= 0

        name = quote_string( name )

        begin
          mysql_result = select_value( "SELECT GET_LOCK('#{name}', #{wait_time.to_f})" )
          mysql_get_lock_obtained = mysql_result.to_s == "1"
          yield if mysql_get_lock_obtained
          return mysql_get_lock_obtained
        ensure
          select_value("SELECT RELEASE_LOCK('#{name}')") if mysql_get_lock_obtained
        end
      end
    end
  end
end
