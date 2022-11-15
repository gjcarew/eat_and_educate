class Api::V1::FavoritesController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    return render json: { error: 'API key not found' }, status: :not_found if user.nil?

    favorite = user.favorites.new(favorites_params)
    if favorite.save
      render json: FavoriteSerializer.success, status: 201
    else
      render json: favorite.errors, status: :bad_request
    end
  end

  def index
    user = User.find_by(api_key: params[:api_key]) 
    return render json: { error: 'API key not found' }, status: :not_found if user.nil?

    render json: FavoriteSerializer.new(user.favorites, is_collection: true)
  end

  def destroy
    user = User.find_by(api_key: params[:api_key])
    return render json: { error: 'API key not found' }, status: :not_found if user.nil?

    favorite = user.favorites.where(id: params[:id])
    if favorite.empty?
      render json: { error: 'Favorite not found' }, status: :not_found
    else
      favorite.first.destroy
      render status: :no_content
    end
  end

  private

  def favorites_params
    params.permit(:country, :recipe_link, :recipe_title)
  end
end
