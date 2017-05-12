# myna
[![CircleCI](https://circleci.com/gh/birdfeed/myna.svg?style=shield)](https://circleci.com/gh/birdfeed/myna)
<a href="https://codeclimate.com/github/AwesomeIT/myna"><img src="https://codeclimate.com/github/AwesomeIT/myna/badges/gpa.svg" /></a>

Concurrent actors for the [turaco](https://github.com/AwesomeIT/turaco) API, written using Ruby, powered by Kafka.

## Getting Started

#### Basic Dependencies
- MRI 2.4.0
- [PocketSphinx](http://cmusphinx.sourceforge.net/wiki/tutorialpocketsphinx)
	- `apt`, `brew`, and the Arch Linux `aur` has this as a package
- Install `elasticsearch`, `docker-compose`, `docker`, and `redis-server` using your distribution's package manager.

#### Kafka

We use Apache Kafka as our message bus. Advanced users can skip this and manually set up `zookeeper` and `kafka` to their liking -- we currently do not do anything exotic. Everybody else is highly encouraged to use this `docker-compose.yml` definition for their Kafka setup.

```yaml
version: '2'
services:
  zookeeper:
    restart: always
    image: wurstmeister/zookeeper
    ports:
      - "2181:2181"

  kafka:
    restart: always
    image: wurstmeister/kafka
    links:
      - zookeeper:zk
    ports:
      - "9092:9092"
    depends_on:
      - zookeeper
    environment:
      KAFKA_ADVERTISED_HOST_NAME: (docker container's IP address)
      KAFKA_ADVERTISED_PORT: (9092, but whatever you want if you NAT it)
      KAFKA_ZOOKEEPER_CONNECT: zk:2181
      KAFKA_CREATE_TOPICS: "sample_speech_recognition:1:1:compact,es_manage:1:1:compact"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```

#### Running everything
- Use `systemctl` or whatever you use for services to start `elasticsearch` and `redis-server`
- In the same directory as your `docker-compose.yml` file, `docker-compose up -d` will run your Kafka/Zookeeper containers in the background.
  - To make sure they're running, please `docker ps` as `root`. 
- `bundle exec karafka w` to start Sidekiq workers (required).
- `bundle exec karafka s` to start the Karafka server.

## Data flow

We want our API to be fast and do as little work as possible outside of presentation and basic CRUD operations, we spawn actors to do the rest of the work. The best way to add a new feature (read: do non-API related work) would be to modify the `PostgresSink` in Turaco to dispatch the correct payloads to a specialized topic.

### Topics

| Topic                     | Purpose                                                                                             |
|---------------------------|-----------------------------------------------------------------------------------------------------|
| es_manage                 | Notified whenever there is a database change to update Elasticsearch with latest data.              |
| sample_speech_recognition | Notified when a `sample` row is inserted, passes audio through CMU Sphinx for inference processing. |

## Credits & License

- David Stancu
- Paulina Levit

Copyright (c) 2017 Awesome IT LLC.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.