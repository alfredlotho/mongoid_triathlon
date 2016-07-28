module Api
  class RacersController < ApplicationController
    
    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/racers"
      else
        @racers = Racer.all
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/racers/#{params[:id]}"
      else
        @racer = Racer.find(params[:id])
      end
    end
  end
end