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
module AIGames
  module FourInARow
    # The playing field consists of cells. Each cell is located in a certain row
    # and column, and can belong to one of the players.
    class Cell
      # The row the cell is in
      attr_reader :row

      # The column the cell is in
      attr_reader :column

      # The bot who fills this cell
      attr_accessor :owner

      # The neighbors of this cell
      attr_accessor :neighbors

      # Initializes the cell with the given position, and optionally the owner.
      def initialize(row, column, owner = nil)
        @row = row
        @column = column
        @owner = owner
        @neighbors = []
      end

      # Returns all neighbors having the same owner.
      def neighbors_with_same_owner
        neighbors.select { |x| x.owner == owner }
      end
    end
  end
end
