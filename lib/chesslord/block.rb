module Chesslord
  class Block
    attr_accessor :player, :piece, :resource

    class << self
      def empty
        new
      end

      def deserialize(serialized_block)
        serialized_player, serialized_piece, serialized_resource = serialized_block.split('|')

        player = Player.deserialize(serialized_player)
        piece = Piece.deserialize(serialized_piece)
        resource = Resource.deserialize(serialized_resource)

        new(player: player, piece: piece, resource: resource)
      end
    end

    def initialize(player: nil, piece: nil, resource: nil)
      @player = player
      @piece = piece
      @resource = resource
    end

    def to_s
      "#{player || 0}|#{piece || 0}|#{resource || 0}"
    end
  end
end
