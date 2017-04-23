# frozen_string_literal: true
class TopicMapper
  def initialize
    @topic_prefix = ENV.fetch('KAFKA_TOPIC_PREFIX', '')
  end

  def incoming(topic)
    topic.gsub("#{topic_prefix}", '')
  end

  def outgoing(topic)
    "#{topic_prefix}#{topic}"
  end

  private

  attr_reader :topic_prefix
end
