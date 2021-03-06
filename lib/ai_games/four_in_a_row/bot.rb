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
require 'ai_games/four_in_a_row/match'

module AIGames
  module FourInARow
    class Bot
      # Time in milliseconds that the bot has in its time bank
      attr_accessor :current_time_bank

      # Maximum time in milliseconds that the bot can have in its time bank
      attr_accessor :maximum_time_bank

      # Time in milliseconds that is added to the bot's time bank each move
      attr_accessor :time_per_move

      # The match instance
      attr_reader :match

      # Initializes a new bot.
      def initialize(match = nil)
        @match = match || Match.instance
      end

      # Places a disk. This method MUST return a single integer value, denoting
      # the column you want to drop a pin in. To customize your bot, overwrite
      # this method with your own implementation.
      def place_disc
        rand(0...match.playing_field.columns)
      end

      # Handles changes on the playing field. Whenever the "owner" of a cell
      # changes, the bot gets notified about it via this method. Overwrite this
      # method to add your own logic.
      def update(cell, new_owner)
      end

      # Starts this bot.
      def run
        @match.parser.run
      end
    end
  end
end
