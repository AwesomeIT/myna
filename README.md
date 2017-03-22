# myna
[![CircleCI](https://circleci.com/gh/birdfeed/myna.svg?style=shield)](https://circleci.com/gh/birdfeed/myna)
<a href="https://codeclimate.com/github/AwesomeIT/myna"><img src="https://codeclimate.com/github/AwesomeIT/myna/badges/gpa.svg" /></a>

Concurrent actors for the [turaco](https://github.com/AwesomeIT/turaco) API, written using Ruby, powered by Kafka.

## Getting Started

### Requirements

#### Host machine base configuration
- Some *nix flavor, or at least a Docker container
- Zookeeper
- Kafka
- MRI 2.4.0

#### Libraries
- [PocketSphinx](http://cmusphinx.sourceforge.net/wiki/tutorialpocketsphinx)
	- `apt`, `brew`, and the Arch Linux `aur` has this as a package

### Setup
- Install `zookeeper` and `kafka` using your operating system's package manager.
- `bundle exec sidekiq` to start Sidekiq workers (required).
- `bundle exec karafka s` to start the Karafka server.
