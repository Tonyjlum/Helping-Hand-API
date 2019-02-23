class SponsorsController < ApplicationController
  def index
    @sponsors = Sponsor.all
    render json: @sponsors
  end

  def show
    @sponsor = Sponsor.find(params[:id])
    render json: @sponsor
  end

end
