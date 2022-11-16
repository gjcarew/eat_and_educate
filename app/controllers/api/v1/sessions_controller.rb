class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email].downcase)
    return render json: { "error": "No user with that email" }, status: :not_found if user.nil?

    if user&.authenticate(params[:password])
      log_in(user)
      render json: UserSerializer.new(user), status: :created
    else 
      render json: { "error": "Incorrect password" }, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
  end

  private

  def log_in(user)
    reset_session
    session[:user_id] = user.id
  end

end