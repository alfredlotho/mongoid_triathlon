class Address
  
  attr_accessor :city, :state, :location

  def initialize(city = nil, state = nil, location = nil)
    @city = city
    @state = state
    @location = location.nil? ? Point.new(0,0) : location
  end

  def mongoize
    case @location
    when Point then {:city=>city, :state=>@state, :loc=>@location.mongoize}
    when Hash then {:city=>@city, :state=>@state, :loc=>@location}
    end      
  end
  
  def self.demongoize(object)
    case object
    when nil then object
    when Address then object
    when Hash then 
      Address.new(object[:city], object[:state], Point.demongoize(object[:loc]))
    end
  end

  def self.mongoize(object) 
    case object
    when nil then object
    when Address then object.mongoize
    when Hash then 
      Address.new(object[:city], object[:state], object[:loc]).mongoize
    end
  end
  
  def self.evolve(object)
    case object
    when Address then object.mongoize
    else object
    end
  end
end
