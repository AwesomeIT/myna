require 'pry'
module Entry
  class Samples < ApplicationController
    def perform_async
      # Send message to all workers that should respond
      # as a part of this action
      binding.pry
      respond_with('butts')
    end
  end
end