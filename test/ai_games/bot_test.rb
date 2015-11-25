require 'test_helper'

module AIGames
  module FourInARow
    class BotTest < Minitest::Test
      def setup
        @bot = Bot.new
      end

      def test_place_disc
        assert_includes 0...7, @bot.place_disc
      end
    end
  end
end
