module Chesslord
  class Game
    class << self
      def deserialize(serialized_game)
      end
    end

    def initialize(player_count: 2, board_size: 16)
      @players = []
      @board = Board.generate(size: board_size, resources: {food: 5, wood: 4, stone: 3, iron: 2, gold: 1})
      @player_in_turn = nil
    end

    def start
    end

    def serialize
    end
  end
end
