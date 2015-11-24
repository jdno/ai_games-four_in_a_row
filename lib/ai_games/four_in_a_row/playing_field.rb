# Copyright (c) 2015 jdno
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
    # This class represents the playing field of the game. It has a given number
    # of columns and rows, and each field can either be empty or filled. If a
    # field is filled, the name of the player whose chip fills the field is
    # stored in it.
    class PlayingField
      # The number of columns of the playing field
      attr_reader :columns

      # The number of rows of the playing field
      attr_reader :rows

      # A two-dimensional array containing all the fields of the playing field
      attr_reader :fields

      # Initialize the playing field with the given number of rows and columns.
      def initialize(rows = 0, columns = 0)
        resize_field rows, columns
      end

      # Shortcut to the field elements, using the playing field itself like the
      # underlying array structure.
      def [](index)
        @fields[index]
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

      def resize_field(rows, columns)
        @columns = columns
        @rows = rows
        @fields = Array.new(rows) { Array.new(columns) { nil } }
      end
    end
  end
end
