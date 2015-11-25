# Copyright (c) 2015 Jan David Nose
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
require 'ai_games/four_in_a_row/bot'
require 'ai_games/four_in_a_row/parser'
require 'ai_games/four_in_a_row/playing_field'
require 'singleton'

module AIGames
  module FourInARow
    # This class maintains a state of the current match and provides access to
    # the bots, the playing field and the parser. It implements the singleton
    # pattern to ensure that only a single instance of the match state exists
    # at any given time.
    class Match
      # This class implements the singleton pattern to ensure that there is only
      # a single instance passed around the application at any time. This is
      # important due to the way information is shared between the parser and
      # the bots.
      include Singleton

      # A hash mapping the ids to the bots, with bots[0] being nil and bots[1]
      # and bots[2] containing the two players.
      attr_reader :bots

      # The player's bot
      attr_reader :my_bot

      # The enemy's bot
      attr_reader :enemy_bot

      # The current round
      attr_accessor :round

      # The instance of the parser
      attr_reader :parser

      # The instance of the playing field
      attr_accessor :playing_field

      # Initializes a new match instance. If a custom bot is given, it is used
      # as the player's bot, else the default bot is used for both the player
      # and the enemy.
      def initialize(bot = nil)
        @bots = {}
        @bots[0] = nil
        @my_bot = bot || Bot.new(self)
        @enemy_bot = Bot.new(self)
        @parser = Parser.new(self)
        @round = 0
        @playing_field = PlayingField.new(6, 7)
      end
    end
  end
end
