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

  def login
    @user = User.find_by(email: user_params["email"], password: user_params["password"])
    if @user
      render json: @user
    else
      return null
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end


end
