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

  def login
    @sponsor = Sponsor.find_by(email: sponsor_params["email"], password: sponsor_params["password"])
    if @sponsor
      render json: @sponsor
    else
      render json: {id: 0, errors: "Incorrect email or password. Please try again."}
    end
  end




  private

  def sponsor_params
    params.require(:sponsor).permit(:email, :password, :first_name, :last_name)
  end


end
