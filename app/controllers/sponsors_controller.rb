class SponsorsController < ApplicationController
  def index
    @sponsors = Sponsor.all
    render json: @sponsors
  end
end
