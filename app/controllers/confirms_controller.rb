class ConfirmsController < ApplicationController

  def index
    @confirms = Confirm.all
    render json: @confirms
  end

  def create
    @confirm = Confirm.create(confirm_params)
    render json: @confirm
  end

  private
  def confirm_params
    params.require(:confirm).permit(:user_id, :event_id)
  end
end
