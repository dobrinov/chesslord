require 'rspec/core'
require 'chesslord'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = %i(should expect)
  end

  config.mock_with :rspec do |c|
    c.syntax = :should
  end
end
