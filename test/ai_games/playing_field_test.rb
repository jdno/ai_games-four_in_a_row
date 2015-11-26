require 'test_helper'
require 'ai_games/four_in_a_row/playing_field'

module AIGames
  module FourInARow
    class PlayingFieldTest < Minitest::Test
      def setup
        @playing_field = PlayingField.new(2, 4)
      end

      def test_initialization
        assert 4, @playing_field.columns
        assert 2, @playing_field.rows

        (0...2).each do |i|
          (0...4).each do |j|
            assert_nil @playing_field.instance_variable_get(:@fields)[i][j]
          end
        end
      end

      def test_get_cell
        bot = Bot.new
        @playing_field.instance_variable_get(:@fields)[0][0] = bot
        assert_equal bot, @playing_field.get_cell(0 , 0)
      end

      def test_set_cell
        bot = Bot.new
        @playing_field.set_cell(0, 0, bot)
        assert_equal bot, @playing_field.instance_variable_get(:@fields)[0][0]
      end

      def test_rows=
        @playing_field.rows = 3

        assert 3, @playing_field.rows
        (0...4).each do |j|
          assert_nil @playing_field.get_cell(2, j)
        end
      end

      def test_columns=
        @playing_field.columns = 5

        assert 5, @playing_field.columns
        (0...2).each do |i|
          assert_nil @playing_field.get_cell(i, 4)
        end
      end
    end
  end
end
