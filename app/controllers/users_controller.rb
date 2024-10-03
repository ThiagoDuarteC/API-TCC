class UsersController < ApplicationController
  before_action :load_user, only: %i[ show update destroy ]

  def index
    @users = User.where(deleted_at: nil)

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
  end

  private
    def load_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:full_name, :username, :email, :password)
    end
end
