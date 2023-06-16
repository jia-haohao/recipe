class RelationshipsController < ApplicationController
  load_and_authorize_resource
  def create
    @user = User.find(relationship_params[:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end
  
  def destroy
    @user = Relationship.find(params[:id]).followed
  #   # @user = current_user.active_relationships.find_by(followed_id: params[:user_id]).followed
  #   # @user = current_user.active_relationships.find_by(followed_id: params[:relationship][:user_id])
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html {redirect_to request.referer}
      format.js
    end
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followed_id, :follower_id)
  end
end
