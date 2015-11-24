require 'test_helper'

module AIGames
  module FourInARow
    class MatchTest < Minitest::Test
      def setup
        @match = Match.instance
      end

      def test_initialize_bots
        assert Hash, @match.bots.class
        assert 1, @match.bots.size
        assert_nil @match.bots[0]
      end

      def test_initialize_round
        assert 0, @match.round
      end

      def test_initialize_playing_field
        assert 6, @match.playing_field.rows
        assert 7, @match.playing_field.columns
      end
    end
  end
end
