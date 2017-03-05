# myna
[![CircleCI](https://circleci.com/gh/birdfeed/myna.svg?style=shield)](https://circleci.com/gh/birdfeed/myna)
<a href="https://codeclimate.com/github/AwesomeIT/myna"><img src="https://codeclimate.com/github/AwesomeIT/myna/badges/gpa.svg" /></a>

Concurrent actors for the [turaco](https://github.com/AwesomeIT/turaco) API, written using Ruby, powered by Kafka.

## Getting Started

### Requirements
- Some *nix flavor, or at least a Docker container
- Zookeeper
- Kafka
- MRI 2.4.0

### Setup
- Install `zookeeper` and `kafka` using your operating system's package manager.
- Edit `Procfile` with appropriate values. 
- `bundle`, then `bundle exec foreman start` to start Zookeeper and Kafka.
	- If on OS X, feel free to just `brew services start zookeeper; brew services start kafka;`
- `bundle exec sidekiq` to start Sidekiq workers (required).
- `bundle exec karafka s` to start the Karafka server.
