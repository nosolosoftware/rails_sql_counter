require 'bundler/setup'
require 'rails_sql_counter'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def simulate_query
    ActiveSupport::Notifications.instrument('sql.active_record', name: 'Load') {}
  end
end
