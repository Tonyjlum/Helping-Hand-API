class ConfirmsController < ApplicationController

  def index
    @confirms = Confirm.all
    render json: @confirms
  end

  def create
    @confirm = Confirm.create(confirm_params)
    @event = @confirm.event
    render json: {confirm: @confirm, event: @event}
  end

  def destroy
    @confirm = Confirm.find(params[:id])
    @confirm_id = @confirm.id
    @confirm.destroy
    render json: {destroyed_confirm_id: @confirm.id}
  end

  private
  def confirm_params
    params.require(:confirm).permit(:user_id, :event_id)
  end
end
