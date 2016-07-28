module Api
  class RacesController < ApplicationController
    
    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races"
      else
        @races = Race.all.order_by(:date => "desc")
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:id]}"
      else
        @race = Race.find(params[:id])
      end
    end
  end
end