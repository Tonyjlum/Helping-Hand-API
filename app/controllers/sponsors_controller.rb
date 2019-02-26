class SponsorsController < ApplicationController
  def index
    @sponsors = Sponsor.all
    render json: @sponsors
  end

  def show
    @sponsors = Sponsor.find(params[:id])
    render json: @sponsors
  end

  def create
    @sponsors = Sponsor.create(sponsor_params)
    render json: @sponsors
  end

  private

  def sponsor_params
    params.require(:sponsor).permit(:email, :password, :first_name, :last_name)
  end


end
