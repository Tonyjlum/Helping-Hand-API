class DonationsController < ApplicationController
  def index
    @donations = Donation.all
    render json: @donations
  end
end
