require 'test_helper'

module AIGames
  class FourInARowTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::AIGames::FourInARow::VERSION
    end
  end
end
