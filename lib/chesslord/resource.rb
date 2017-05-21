module Chesslord
  module Resource
    extend self

    def deserialize(serialized_resource)
      case serialized_resource
      when 'F' then Food
      when 'W' then Wood
      when 'S' then Stone
      when 'I' then Iron
      when 'G' then Gold
      when '0' then nil
      else
        raise "Invalid resource #{serialized_resource}"
      end
    end
  end
end
