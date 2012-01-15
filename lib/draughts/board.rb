module Draughts
  SquareNotEmptyException = Class.new(Exception)

  class Board
    def initialize
      @pieces = init_pieces
    end

    # Takes an integer in the range (1..32), which is standard notation for
    # checkers. This encapsulates the underlying Array.
    #
    def piece_at(pos)
      @pieces[pos - 1]
    end

    alias :[] :piece_at

    def move(from, to)
      from -= 1
      to   -= 1

      raise SquareNotEmptyException if @pieces[to]

      puts "Moved from #{from} to #{to}"
    end

    def count(color)
      color == :blacks ? blacks_count : whites_count
    end

    def whites_count
      @pieces.count { |p| !p.nil? && p.color == :white }
    end

    def blacks_count
      @pieces.count { |p| !p.nil? && p.color == :black }
    end

    def to_s
      piece_squares = @pieces.reverse
      empty_squares = [" "] * 4
      buf = []

      8.times do |row_index|
        row = piece_squares[row_index * 4, 4]

        if row_index.even?
          first  = empty_squares
          second = row
        else
          first  = row
          second = empty_squares
        end

        4.times do |col_index|
          buf << first[col_index].to_s
          buf << second[col_index].to_s
        end

        buf << "\n"
      end

      buf.map { |c| c == "" ? " " : c }.join
    end

    private

    def init_pieces
      pieces = []

      12.times { pieces.insert(0,  BlackPiece.new) }
      12.times { pieces.insert(20, WhitePiece.new) }

      pieces
    end
  end
end
