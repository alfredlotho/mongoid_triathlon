module Api
  class ResultsController < ApplicationController
    
    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:race_id]}/results"
      else
        @results = Race.find(params[:race_id]).entrants
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
      else
        @result = Race.find(params[:race_id]).entrants.where(:id => params[:id]).first
      end
    end
  end
end