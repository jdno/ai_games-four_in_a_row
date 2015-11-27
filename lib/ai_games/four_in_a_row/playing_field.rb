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
require 'ai_games/four_in_a_row/cell'
require 'observer'

module AIGames
  module FourInARow
    # This class represents the playing field of the game. It has a given number
    # of columns and rows, and each field can either be empty or filled. If a
    # field is filled, the name of the player whose chip fills the field is
    # stored in it.
    class PlayingField
      # Implement observer pattern to notify bots when the owner of a cell
      # changes.
      include Observable

      # The number of columns of the playing field
      attr_reader :columns

      # The number of rows of the playing field
      attr_reader :rows

      # Initialize the playing field with the given number of rows and columns.
      def initialize(rows = 0, columns = 0)
        resize_field rows, columns
      end

      # Returns the cell at the given position.
      def get_cell(row, column)
        @fields[row][column]
      end

      # Returns all cells in the given area. Pass in two ranges to limit area.
      def get_cells(rows, columns)
        cells = []
        rows.each do |r|
          columns.each do |c|
            cells << @fields[r][c]
          end
        end
        cells
      end

      # Updates a cell. If the owner of the cell changes, all observers of the
      # playing field get notified.
      def set_cell(row, column, owner)
        cell = @fields[row][column]
        current_owner = cell.owner
        return if current_owner == owner

        cell.owner = owner
        notify_observers(cell, owner)
      end

      # Sets number of rows. If the new number of rows is greater than the
      # current number of rows, the array gets resized.
      def rows=(rows)
        resize_field rows, @columns
      end

      # Sets the number of columns. If the new number of columns is greater than
      # the current number of columns, the array gets resized.
      def columns=(columns)
        resize_field @rows, columns
      end

      private

      # Fills the playing field with cells.
      def create_cells
        (0...rows).each do |r|
          (0...columns).each do |c|
            @fields[r][c] = Cell.new(r, c)
          end
        end
      end

      # Find all neighbors of a cell.
      def find_neighbors(cell)
        min_r = [0, cell.row - 1].max
        max_r = [cell.row + 1, rows - 1].min
        min_c = [0, cell.column - 1].max
        max_c = [cell.column + 1, columns - 1].min

        get_cells(min_r..max_r, min_c..max_c).select { |x| x unless x == cell }
      end

      # Sets up neighbor relationships for all cells.
      def link_cells
        (0...rows).each do |r|
          (0...columns).each do |c|
            cell = @fields[r][c]
            cell.neighbors = find_neighbors(cell)
          end
        end
      end

      # Resizes the playing field. Each time this method gets called, a new
      # array is created and filled with new cells.
      def resize_field(rows, columns)
        @fields = Array.new(rows) { Array.new(columns) }
        @columns = columns
        @rows = rows
        create_cells
        link_cells
      end
    end
  end
end
