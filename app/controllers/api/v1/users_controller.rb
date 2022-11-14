class Api::V1::UsersController < ApplicationController
  def create
    return render status: 400 unless request.query_parameters.empty?
    user = User.new(user_params)
    while user.api_key.nil? || User.exists?(api_key: user.api_key)
      user.api_key = SecureRandom.urlsafe_base64
    end

    if user.save
      render json: UserSerializer.new(user), status: :created
    else 
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end