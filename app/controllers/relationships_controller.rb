class RelationshipsController < ApplicationController
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
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followed_id, :follower_id)
  end
end