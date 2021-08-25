# RailsSqlCounter

Keep under control how many sql queries are launched in your App

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_sql_counter'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rails_sql_counter

## Doc

### Configuration

* **backtrace**: activates / desactivates sql query backtrace
* **backtrace_regex**: allows to ignore lines from backtrace (line is ignore if it match)

### Methods

* **start**: starts to count sql queries
* **end**: ends to count sql queries
* **counter**: returns number of sql queries from start
* **profile**: syntax sugar to facilitate start/end

## Usage

Test example:
```ruby
context '...' do
  before { RailsSqlCounter.start }
  after { RailsSqlCounter.end }

  it 'returns results with only one query' do
    get path

    expect(RailsSqlCounter.counter).to eq(1)
  end
end

# You could also use .profile
context '...' do
  it 'returns results with only one query' do
    RailsSqlCounter.profile { get path }

    expect(RailsSqlCounter.counter).to eq(1)
  end
end
```
You may want to wrap the tests as:

```ruby
config.around(:each, :max_queries) do |example|
  RailsSqlCounter.profile { example.run }

  if RailsSqlCounter.counter > example.metadata[:max_queries]
    raise 'Maximum number of queries overpassed.'
  end
end

(...)

it 'returns results with only one query', max_queries: 1 do
  get path
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rails_sql_counter.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
