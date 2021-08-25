# frozen_string_literal: true

require 'rails_sql_counter/version'
require 'active_support'

# Count sql queries
module RailsSqlCounter
  mattr_accessor :backtrace, default: false
  mattr_accessor :backtrace_regex, default: /(action|active|pry|rack|puma|rspec|bundle)/

  def self.setup
    yield self
  end

  def self.process(event)
    return unless event.payload[:name]&.match?('Load') && Thread.current[:rails_sql_counter]

    inc
    show_backtrace if @@backtrace
  end

  def self.inc
    Thread.current[:rails_sql_counter] += 1
  end

  def self.start
    Thread.current[:rails_sql_counter] = 0

    @@subscriber ||= ActiveSupport::Notifications.subscribe('sql.active_record') do |event|
      process(event)
    end
  end

  def self.end
    ActiveSupport::Notifications.unsubscribe(@@subscriber)
    @@subscriber = nil
  end

  def self.counter
    Thread.current[:rails_sql_counter]
  end

  def self.show_backtrace
    # remove first two entries (gem entries)
    caller.drop(2).each do |line|
      next if line.match?(@@backtrace_regex)

      Rails.logger.debug "    -> #{line}"
    end
  end

  private_class_method :inc, :show_backtrace, :process
end
