class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email].downcase)
    if user&.authenticate(params[:password])
      log_in(user)
      render json: UserSerializer.new(user), status: :created
    else 
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
  end

  private

  def log_in(user)
    reset_session
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end