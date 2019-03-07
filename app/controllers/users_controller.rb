class UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.create(user_params)
    render json: @user
  end

  def user_events
    @user_events = User.find(user_params["id"]).events
    render json: @user_events
  end

  def login
    @user = User.find_by(email: user_params["email"], password: user_params["password"])
    if @user
      render json: @user
    else
      render json: {id: 0, errors: "Incorrect email or password. Please try again. From User"}
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end


end
