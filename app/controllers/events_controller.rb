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
    @confirm = Confirm.create(user_id: event_params[:coordinator_id], event_id: @event.id)
    render json: @event
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    render json: @event
  end

  def destroy
    @event = Event.find(params[:id])
    @event_id = @event.id
    @event.destroy
    render json: {destroyed_event_id: @event_id.id}
  end

  private
  def event_params
    params.require(:event).permit(:coordinator_id, :datetime, :title, :max_volunteers, :address, :description, :lat, :long)
  end


end
