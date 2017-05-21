module Chesslord
  class Board
    attr_accessor :blocks

    class << self
      def generate(size: 16, resources: {food: 0, wood: 0, stone: 0, iron: 0, gold: 0})
        resources_count = resources.map { |_, v| v }.inject(0, :+)
        block_count = size ** 2
        empty_block_count = block_count - resources_count

        raise 'There are more resources than blocks' if empty_block_count < 0

        empty_blocks = [nil] * empty_block_count
        resource_distribution =
          (empty_blocks + resources.map { |k, v| [Chesslord.const_get(k.capitalize)] * v }.flatten).
            shuffle.
            each_slice(size).
            to_a

        board = new(size: size)

        board.blocks.each_with_index do |_, row|
          board.blocks[row].each_with_index do |_, column|
            next unless resource_distribution[row][column]

            board.blocks[row][column].resource = resource_distribution[row][column]
          end
        end

        board
      end

      def deserialize(serialized_board)
        size = serialized_board.split("\n").size

        board = Board.new(size: size)

        serialized_board.split("\n").each_with_index do |row_blocks, row|
          row_blocks.split(' ').each_with_index do |serialized_block, column|
            board.blocks[row][column] = Block.deserialize(serialized_block)
          end
        end

        board
      end
    end

    def initialize(size: 16)
      @blocks = Array.new(size) { Array.new(size) }

      @blocks.each_with_index do |_, row|
        @blocks[row].each_with_index do |_, column|
          @blocks[row][column] = Block.empty
        end
      end
    end

    def serialize
      @blocks.map { |block| block.join(' ') }.join("\n") + "\n"
    end

    def capture_block(player, row, column)
      @blocks[row][column].player = player
    end

    def release_block(row, column)
      @blocks[row][column].player = nil
    end

    def place_piece(player, piece, row, column)
      @blocks[row][column].piece = piece
      capture_block(player, row, column)
    end

    def remove_piece(row, column)
      @blocks[row][column].piece = nil
    end

    def to_s
      serialize
    end
  end
end
