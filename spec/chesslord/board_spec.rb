require 'spec_helper'

module Chesslord
  describe Board do
    it 'creates an empty board' do
      Board.new(size: 3).to_s.should eq <<~BOARD
                                          0|0|0 0|0|0 0|0|0
                                          0|0|0 0|0|0 0|0|0
                                          0|0|0 0|0|0 0|0|0
                                        BOARD
    end

    it 'generates a board with specific amount of resources' do
      board = Board.generate(size: 4, resources: {food: 5, wood: 4, stone: 3, iron: 2, gold: 1})

      resources = board.to_s.split("\n").map { |row| row.split(' ').map { |block| block.split('|')[2] } }.flatten

      resources.count('F').should eq 5
      resources.count('W').should eq 4
      resources.count('S').should eq 3
      resources.count('I').should eq 2
      resources.count('G').should eq 1
    end

    it 'captures/releases block by player' do
      board = Board.new(size: 3)
      player = Player.new(id: 1)

      board.capture_block(player, 1, 1)

      board.to_s.should eq <<~BOARD
                             0|0|0 0|0|0 0|0|0
                             0|0|0 1|0|0 0|0|0
                             0|0|0 0|0|0 0|0|0
                           BOARD

      board.release_block(1, 1)

      board.to_s.should eq <<~BOARD
                             0|0|0 0|0|0 0|0|0
                             0|0|0 0|0|0 0|0|0
                             0|0|0 0|0|0 0|0|0
                           BOARD
    end

    it 'places/removes piece on/from block' do
      board = Board.new(size: 3)
      player = Player.new(id: 1)
      piece = King

      board.place_piece(player, piece, 1, 1)

      board.to_s.should eq <<~BOARD
                             0|0|0 0|0|0 0|0|0
                             0|0|0 1|K|0 0|0|0
                             0|0|0 0|0|0 0|0|0
                           BOARD

      board.remove_piece(1, 1)

      board.to_s.should eq <<~BOARD
                             0|0|0 0|0|0 0|0|0
                             0|0|0 1|0|0 0|0|0
                             0|0|0 0|0|0 0|0|0
                           BOARD
    end

    it 'can be serialized and deserialized' do
      serialized_board = <<~BOARD
        1|K|F 2|K|0 2|0|0
        0|0|0 1|0|S 0|0|0
        0|0|W 0|0|G 1|0|I
      BOARD

      board = Board.deserialize(serialized_board)

      board.blocks[0][0].player.to_s.should eq '1'
      board.blocks[0][0].piece.to_s.should eq 'K'
      board.blocks[0][0].resource.to_s.should eq 'F'

      board.blocks[0][1].player.to_s.should eq '2'
      board.blocks[0][1].piece.to_s.should eq 'K'
      board.blocks[0][1].resource.should be_nil

      board.blocks[0][2].player.to_s.should eq '2'
      board.blocks[0][2].piece.should be_nil
      board.blocks[0][2].resource.should be_nil

      board.blocks[1][0].player.should be_nil
      board.blocks[1][0].piece.should be_nil
      board.blocks[1][0].resource.should be_nil

      board.blocks[1][1].player.to_s.should eq '1'
      board.blocks[1][1].piece.should be_nil
      board.blocks[1][1].resource.to_s.should eq 'S'

      board.blocks[1][2].player.should be_nil
      board.blocks[1][2].piece.should be_nil
      board.blocks[1][2].resource.should be_nil

      board.blocks[2][0].player.should be_nil
      board.blocks[2][0].piece.should be_nil
      board.blocks[2][0].resource.to_s.should eq 'W'

      board.blocks[2][1].player.should be_nil
      board.blocks[2][1].piece.should be_nil
      board.blocks[2][1].resource.to_s.should eq 'G'

      board.blocks[2][2].player.to_s.should eq '1'
      board.blocks[2][2].piece.should be_nil
      board.blocks[2][2].resource.to_s.should eq 'I'

      board.to_s.should eq serialized_board
    end
  end
end
