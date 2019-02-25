class EventsController < ApplicationController

  def index
    @events = Event.all
    render json: @events
  end

  def show
    @event = Event.find(params[:id])
    render json: @event
  end

  def create
    @event = Event.create(event_params)
    render json: @event
  end


  private
  def event_params
    params.require(:event).permit(:coordinator_id, :datetime, :title, :max_volunteers, :address, :description, :lat, :long)
  end


end
