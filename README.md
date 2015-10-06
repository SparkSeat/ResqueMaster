# ResqueMaster

ResqueMaster is a simple way of sending all Resque jobs to a master server
using rabbitmq.

At SparkSeat, we use this to gather jobs from siteboxes and run them on our own
servers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'resque_master'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resque_master

## Configuration

Out of the box, ResqueMaster will work with Resque.

If you require other plugins (such as `resque-scheduler` or `resque-status`), you
will need to write and load plugins. An example plugin is provided for
`resque-scheduler`.

On load, ResqueMaster reads `config/resque_master.yml`. A sample is included in
`config/resque_master.yml`, and is copied here for convenience:

```yaml
plugins:
  - resque_master/plugins/resque_scheduler
```

Currently, no Bunny configuration is possible, although pull requests would be
welcomed.

## Usage

On your client:

```ruby
require 'resque_master'

ResqueMaster.enqueue(MyJob, args)
```

Then, on your server:

    $ resque-master

## Plugins

Please refer to `plugins/resque` and `plugins/resque_scheduler`.

In essence a plugin must be a class that calls
`ResqueMaster.add_resque_methods` in its initializer, and `require`s
any dependencies.

The plugin must also register itself
`ResqueMaster.register_plugin(ResqueMaster::Plugins::Resque)`

## Development

After checking out the repo, run `bundle install` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SparkSeat/resque_master.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
