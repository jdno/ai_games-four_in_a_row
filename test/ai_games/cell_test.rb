require 'test_helper'

module AIGames
  module FourInARow
    class CellTest < Minitest::Test
      def setup
        @bot = Bot.new
        @cell = Cell.new(2, 4, @bot)
      end

      def test_initialize
        assert_equal 2, @cell.row
        assert_equal 4, @cell.column
        assert_equal @bot, @cell.owner
      end
    end
  end
end
