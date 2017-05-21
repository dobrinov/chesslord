module Chesslord
  class Player
    attr_reader :id

    class << self
      def deserialize(serialized_player)
        case serialized_player.to_i
        when 0 then nil
        else
          new(id: serialized_player.to_i)
        end
      end
    end

    def initialize(id:)
      @id = id
    end

    def to_s
      id.to_s
    end
  end
end
