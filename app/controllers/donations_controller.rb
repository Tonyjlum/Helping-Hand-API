class DonationsController < ApplicationController
  def index
    @donations = Donation.all
    render json: @donations
  end
  def show

    @donation = Donation.find(params[:id])
    render json: @donation
  end

  def create
    @donation = Donation.create(donations_parmas)
    render json: @donation
  end

  private
  def donations_parmas
    params.require(:donation).permit(:event_id, :sponsor_id, :amount_per_volunteer)
  end
end
