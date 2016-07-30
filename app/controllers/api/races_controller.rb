module Api
  class RacesController < ApplicationController
    protect_from_forgery with: :null_session
  
    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      @msg = "woops: cannot find race[#{params[:id]}]"
      if !request.accept || request.accept == "*/*"
        render plain: @msg, status: :not_found
      else
        respond_to do |format|
          format.json { render "api/error_msg", status: :not_found, content_type: "#{request.accept}" }
          format.xml  { render "api/error_msg", status: :not_found, content_type: "#{request.accept}" }
        end
      end
    end

    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
      else
        @races = Race.all.order_by(:date => "desc")
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:id]}"
      else
        @race = Race.find(params[:id])
        respond_to do |format|
          format.json { render "api/races/race", status: :ok, content_type: "#{request.accept}" }
          format.xml  { render "api/races/race", status: :ok, content_type: "#{request.accept}" }
        end
      end
    end

    def create
      if !request.accept || request.accept == "*/*"
        #stub function
        race = Race.new(:name => params[:race][:name])
        race.save
        render plain: race.name, status: :ok
      else
        race = Race.new(race_params)
        race.save
        render plain: race.name, status: :created
      end
    end

    def update
      race = Race.find(params[:id])
      race.update(race_params)
      render json: race, status: :ok
    end

    def destroy
      race = Race.find(params[:id])
      race.destroy
      render :nothing=>true, :status => :no_content
    end

    private
      def race_params
        params.require(:race).permit(:name,:date)
      end

  end
end