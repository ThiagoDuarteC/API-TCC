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
      token = encode_token(@user.id)
      render json: { token: token }, status: :created
    else
      render json: { errors: ['Erro ao criar usuário'] }, status: :unprocessable_entity
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
    def encode_token(user_id)
      JWT.encode({user_id: user_id}, Rails.application.secret_key_base)
    end

    def load_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:full_name, :username, :email, :password)
    end
end
