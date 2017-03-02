require 'active_support'
require 'active_support/core_ext'
require 'kagu'

module Adapters
  extend ActiveSupport::Autoload

  autoload :S3
end