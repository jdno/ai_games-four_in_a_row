require 'test_helper'
require 'ai_games/four_in_a_row/match'
require 'ai_games/four_in_a_row/parser'

module AIGames
  module FourInARow
    class ParserTest < Minitest::Test
      def setup
        @input = StringIO.new
        @output = StringIO.new
        @match = Match.instance
        @match.playing_field.rows    = 2
        @match.playing_field.columns = 3
        @match.bots[1] = @match.my_bot
        @match.bots[2] = @match.enemy_bot
        @parser = Parser.new(@match, input: @input, output: @output)
      end

      def test_initialize
        assert @match, @parser.match
      end

      def test_update_round
        @parser.parse %w(update game round 1)
        assert 1, @match.round
      end

      def test_update_field
        @parser.parse %w(update game field 0,2,0;1,0,0)
        assert_equal @match.bots[1], @match.playing_field.get_cell(1, 0).owner
        assert_equal @match.bots[2], @match.playing_field.get_cell(0, 1).owner
      end

      def test_settings_timebank
        @parser.parse %w(settings timebank 1000)
        assert 1000, @match.my_bot.maximum_time_bank
        assert 1000, @match.enemy_bot.maximum_time_bank
      end

      def test_settings_time_per_move
        @parser.parse %w(settings time_per_move 50)
        assert 50, @match.my_bot.time_per_move
        assert 50, @match.enemy_bot.time_per_move
      end

      def test_settings_bot_id
        @parser.parse %w(settings your_botid 2)
        assert @match.enemy_bot, @match.bots[1]
        assert @match.my_bot,    @match.bots[2]
      end

      def test_settings_columns
        @parser.parse %w(settings field_columns 4)
        assert 4, @match.playing_field.columns
      end

      def test_settings_rows
        @parser.parse %w(settings field_rows 2)
        assert 2, @match.playing_field.rows
      end
    end
  end
end
