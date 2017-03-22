# frozen_string_literal: true
module Controllers
  class Events < Base
    def perform_async
      respond_with params[:message]
    end
  end
end
