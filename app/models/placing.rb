class Placing
  include Mongoid::Document
  field :name, type: String
  field :place, type: Integer

  attr_accessor :name, :place

  def initialize(name, place)
    @name = name
    @place = place
  end

  def mongoize
    {:name=>@name, :place=>@place}
  end
  
  def self.demongoize(object)
    case object
    when nil then object
    when Placing then object
    when Hash then 
      Placing.new(object[:name], object[:place])
    end
  end

  def self.mongoize(object) 
    case object
    when nil then object
    when Placing then object.mongoize
    when Hash then 
      Placing.new(object[:name], object[:place]).mongoize
    end
  end
  
  def self.evolve(object)
    case object
    when Placing then object.mongoize
    else object
    end
  end
end
