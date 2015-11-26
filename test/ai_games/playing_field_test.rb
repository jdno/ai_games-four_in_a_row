require 'test_helper'

module AIGames
  module FourInARow
    class PlayingFieldTest < Minitest::Test
      def setup
        @playing_field = PlayingField.new(2, 4)
        @fields = @playing_field.instance_variable_get(:@fields)
      end

      def test_initialization
        assert 4, @playing_field.columns
        assert 2, @playing_field.rows

        (0...2).each do |i|
          (0...4).each do |j|
            assert_kind_of Cell, @fields[i][j]
          end
        end
      end

      def test_get_cell
        bot = Bot.new
        @fields[0][0] = bot
        assert_equal bot, @playing_field.get_cell(0, 0)
      end

      def test_set_cell
        bot = Bot.new
        @playing_field.set_cell(0, 0, bot)
        assert_equal bot, @fields[0][0].owner
      end

      def test_rows=
        @playing_field.rows = 3

        assert 3, @playing_field.rows
        (0...4).each do |j|
          assert_kind_of Cell, @playing_field.get_cell(2, j)
        end
      end

      def test_columns=
        @playing_field.columns = 5

        assert 5, @playing_field.columns
        (0...2).each do |i|
          assert_kind_of Cell, @playing_field.get_cell(i, 4)
        end
      end
    end
  end
end
