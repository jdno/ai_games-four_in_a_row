require 'test_helper'

module AIGames
  module FourInARow
    class PlayingFieldTest < Minitest::Test
      def setup
        @rows = 4
        @columns = 5
        @playing_field = PlayingField.new(@rows, @columns)
        @fields = @playing_field.instance_variable_get(:@fields)
      end

      def test_initialize
        assert @rows, @playing_field.rows
        assert @columns, @playing_field.columns

        (0...@rows).each do |i|
          (0...@columns).each do |j|
            assert_kind_of Cell, @fields[i][j]
          end
        end
      end

      def test_initialize_neighbors
        assert_equal 3, @fields[0][0].neighbors.size
        assert_equal 8, @fields[1][1].neighbors.size
      end

      def test_get_cell
        bot = Bot.new
        @fields[0][0] = bot
        assert_equal bot, @playing_field.get_cell(0, 0)
      end

      def test_get_cells
        cells = @playing_field.get_cells(0..2, 0..2)
        assert_equal 9, cells.size
      end

      def test_set_cell
        bot = Bot.new
        @playing_field.set_cell(0, 0, bot)
        assert_equal bot, @fields[0][0].owner
      end

      def test_rows=
        @playing_field.rows = @rows + 1

        assert @rows + 1, @playing_field.rows
        (0...@columns).each do |c|
          assert_kind_of Cell, @playing_field.get_cell(@rows, c)
        end
      end

      def test_columns=
        @playing_field.columns = @columns + 1

        assert @columns + 1, @playing_field.columns
        (0...@rows).each do |r|
          assert_kind_of Cell, @playing_field.get_cell(r, @columns)
        end
      end
    end
  end
end
