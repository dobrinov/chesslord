module Chesslord
  module Piece
    extend self
    def deserialize(serialized_piece)
      type =
        case serialized_piece
        when 'P' then Pawn
        when 'N' then Knight
        when 'B' then Bishop
        when 'R' then Rook
        when 'Q' then Queen
        when 'K' then King
        when '0' then nil
        else
          raise "Invalid piece #{serialized_piece}"
        end
    end
  end
end
