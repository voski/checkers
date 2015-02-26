class Piece
  attr_accessor :color, :pos, :board, :king
  attr_reader :symbol

  def initialize(pos, board, color = nil, king = false)
    self.color = color
    self.color = pos[0] == (0 || 1) ?  :black : :white unless color
  end



  def king?
    self.king
  end

  private

  def move_diffs
    raise 'invalid color' unless color == (:white || :black)
    if self.king
      move_diffs = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
    elsif self.color == :white
      move_diffs = [[-1, -1], [-1, 1]]
    elsif self.color == :black
      move_diffs =[[1, -1], [1, 1]]
    end
    move_diffs
  end


end

pimp = Piece.new([5,3], 1)

p pimp.color
