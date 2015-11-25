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
require 'ai_games/logger'
require 'ai_games/parser/abstract_parser'

module AIGames
  module FourInARow
    # The parser handles the communication with the game engine. It sets up the
    # game using the information provided by the engine before the game starts,
    # and updates the match when new information comes in.
    class Parser < AIGames::Parser::AbstractParser
      # The match instance
      attr_reader :match

      # Initializes the parser with the given match instance.
      def initialize(match, options = nil)
        super(options)
        @match = match
      end

      # For the methods parsing the input, a few cops have been disabled.
      # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/LineLength

      # Parses the game engine's commands. This overwrites DefaultParser.parse
      # with the specific instructions needed for the "Four In A Row"
      # competition.
      def parse(command_array)
        case command_array[0]
        when 'action'
          parse_action command_array[2].to_i
        when 'update'
          parse_update command_array[2..-1]
          return nil
        when 'settings'
          parse_settings command_array[1..-1]
          return nil
        else
          Logger.warn('Parser.parse : Unknown command ' \
            "'#{command_array.join ' '}'")
        end
      end

      private

      # Parses all commands starting with "action". Right now, this is true only
      # for a single command. The response to this command is the move the bot
      # wants to make.
      def parse_action(time_bank)
        @match.my_bot.current_time_bank = time_bank
        "place_disc #{@match.my_bot.place_disc}"
      end

      # Parses all commands starting with "update". This is either the number of
      # round, or an update to the playing field.
      def parse_update(updates_array)
        case updates_array[0]
        when 'round'
          match.round = updates_array[1].to_i
        when 'field'
          parse_field updates_array[1]
        else
          Logger.warn("Parser.parse_updates : Unknown command 'update game" \
            "#{updates_array.join ' '}'")
        end
      end

      # Parses all commands starting with "settings". These are issued once when
      # the game starts, and configure the game.
      def parse_settings(settings_array)
        case settings_array[0]
        when 'timebank'
          parse_time_bank settings_array[1].to_i
        when 'time_per_move'
          parse_time_per_move settings_array[1].to_i
        when 'player_names'
          # Names are irrelevant, do nothing.
        when 'your_bot'
          # Names are irrelevant, do nothing.
        when 'your_botid'
          parse_bot_id settings_array[1].to_i
        when 'field_columns'
          parse_columns settings_array[1].to_i
        when 'field_rows'
          parse_rows settings_array[1].to_i
        else
          Logger.warn("Parser.parse_settings : Unknown command 'settings " \
                          "#{settings_array.join ' '}'")
        end
      end

      # rubocop:enable all

      # Parses the updated playing field. The only argument is the new playing
      # field encoded as a string.
      def parse_field(field_string)
        i = 0
        field_string.split(';').each do |r|
          j = 0
          r.split(',').each do |c|
            match.playing_field[i][j] = match.bots[c.to_i]
            j += 1
          end
          i += 1
        end
      end

      # Sets up the bot ids in the beginning of the game.
      def parse_bot_id(id)
        match.bots[id] = match.my_bot

        if id == 1
          match.bots[2] = match.enemy_bot
        else
          match.bots[1] = match.enemy_bot
        end
      end

      # Sets the playing field's number of columns
      def parse_columns(columns)
        match.playing_field.columns = columns
      end

      # Sets the playing field's number of rows
      def parse_rows(rows)
        match.playing_field.rows = rows
      end

      # Sets the maximum time bank the bots can use
      def parse_time_bank(time_bank)
        match.my_bot.maximum_time_bank    = time_bank
        match.enemy_bot.maximum_time_bank = time_bank
      end

      # Sets the time that is added with each move
      def parse_time_per_move(time)
        match.my_bot.time_per_move    = time
        match.enemy_bot.time_per_move = time
      end
    end
  end
end
