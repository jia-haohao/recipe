class FavoritesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @favorites = current_user.favorites.includes(:cook)
  end

  def create
    @favorite = current_user.favorites.create(cook_id: params[:cook_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @cook = Cook.find(params[:cook_id])
    @favorite = current_user.favorites.find_by(cook_id: @cook.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
