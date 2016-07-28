module Api
  class EntriesController < ApplicationController
    
    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/racers/#{params[:racer_id]}/entries"
      else
        @entries = Racer.find(params[:racer_id]).entrants
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/racers/#{params[:racer_id]}/entries/#{params[:id]}"
      else
        @racer = Racer.find(params[:racer_id]).info
        @entry = Entrant.where(:"racer._id" => @racer[:_id], :id => params[:id])
      end
    end
  end
end