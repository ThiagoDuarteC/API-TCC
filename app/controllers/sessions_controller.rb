class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token(user.id)
      render json: { token: token }, status: :ok
    else
      render json: { errors: ['E-mail ou senha incorretos'] }, status: :unauthorized
    end
  end

  private

  def encode_token(user_id)
    JWT.encode({user_id: user_id}, Rails.application.secret_key_base)
  end
end
