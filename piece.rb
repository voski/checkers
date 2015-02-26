require_relative 'board.rb'
require 'byebug'

class Piece
  attr_accessor :color, :pos, :board, :king
  attr_reader :symbol

  def initialize(pos, board, color = nil, king = false)
    self.pos = pos
    self.board = board
    unless color
      self.color = pos[0] == (0 || 1) ? :black : :white
    else
      self.color = color
    end

    self.king = king
    board.add_piece(self, pos)
  end

  def perform_slide(dest)
    case scout(dest)
    when :empty
      if possible_moves.include?(dest)
        self.board[dest] = self
        self.board[pos] = nil
        self.pos = dest
      else
        raise "Pieces don't move that way"
      end
    when :friendly
      raise 'Ally in the way'
    when :hostile
      raise 'Enemy you must attack'
    end

  end

  def perform_jump(dest)
    case scout(dest)
    when :empty
      if possible_moves.include?(dest)
        mid = [(pos[0] + dest[0]) / 2, (pos[1] + dest[1]) / 2]
        self.board[dest] = self
        self.board[pos] = nil
        self.board[mid] = nil
        self.pos = dest
      else
        raise "Pieces don't move that way"
      end
    when :friendly
      raise 'Ally in the way'
    when :hostile
      raise 'Enemy you must attack'
    end
  end

  def maybe_promote
  end

  def possible_moves
    moves = []
    move_diffs.each do |dx, dy|
      new_moves = explore_unblocked(dx,dy)
      moves.concat(new_moves)
    end

    moves
  end

  private

    def king?
      self.king
    end

    def explore_unblocked(dx, dy)
      cur_x, cur_y = pos
      results = []

      cur_x, cur_y = cur_x + dx, cur_y + dy
      cell = [cur_x, cur_y]
      return unless board.valid_pos?(cell)

      case scout(cell)
      when :empty
        results << cell
      when :friendly
        # return
      when :hostile
        cur_x, cur_y = cur_x + dx, cur_y + dy
        results << [cur_x, cur_y]
        # return # just want to jump once for now
      end

      results
    end

    def move_diffs
      raise 'invalid color' unless color == (:white || :black)
      if self.king
        [[-1, -1], [-1, 1], [1, -1], [1, 1]]
      elsif self.color == :white
        [[-1, -1], [-1, 1]]
      elsif self.color == :black
        [[1, -1], [1, 1]]
      end
    end

    def scout(dest)
      target = self.board.info(dest)
      if self.board.info(dest) == :empty
        :empty
      elsif target.color == color
        :friendly
      else
        :hostile
      end
    end
  # end of private methods
end

board = Board.new
pimp = Piece.new([5,3], board)
ho = Piece.new([4,2], board, color = :black)

# pimp.perform_slide([4,2])

p pimp.possible_moves
p ho.pos
