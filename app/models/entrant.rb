class Entrant
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: 'results'

  field :bib, type: Integer
  field :secs, type: Float
  field :o, as: :overall, type: Placing
  field :gender, type: Placing
  field :group, type: Placing

  embeds_many :results, class_name: "LegResult", order: [:"event.o".asc], after_add: :update_total
  embeds_one :race, class_name: "RaceRef"
  embeds_one :racer, class_name: "RacerInfo", as: :parent

  def update_total(result)
    self.secs = results.map{ |result| result[:secs] }.reduce(:+)
  end

  def the_race
    race.race
  end
end