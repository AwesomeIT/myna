# frozen_string_literal: true
%w(puma sidekiq/web).each(&method(:require))
require Karafka.boot_file

use Rack::Auth::Basic, 'Protected Area' do |username, password|
  username == 'sidekiq' &&
    password == 'Pa$$WorD!'
end

run Sidekiq::Web
