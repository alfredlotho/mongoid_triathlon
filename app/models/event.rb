class Event
  include Mongoid::Document

  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String

  embedded_in :parent, polymorphic: true, touch: true

  validates_presence_of :order, message: "can't be blank"
  validates_presence_of :name, message: "can't be blank"

  def meters
  	case self.u
  	when "kilometers" then self.d * 1000
  	when "miles" then self.d * 1609.344
  	when "yards" then self.d * 0.9144
  	when "meters" then self.d
  	else nil
  	end
  end

  def miles
  	case self.u
  	when "meters" then self.d * 0.000621371
  	when "kilometers" then self.d * 0.621371
  	when "yards" then self.d * 0.000568182
  	when "miles" then self.d
  	else nil
  	end
  end
end
