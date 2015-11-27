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

      def test_neighbors_with_same_owner
        cell1 = Cell.new(1, 4)
        cell2 = Cell.new(3, 4, @bot)
        cell3 = Cell.new(4, 3, @bot)
        @cell.neighbors << cell1 << cell2 << cell3
        assert_equal [cell2, cell3], @cell.neighbors_with_same_owner
      end
    end
  end
end
