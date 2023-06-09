class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_cook, only: [:create, :edit, :update]
  
  def create 
    @comment = @cook.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to cook_path(@cook), alert: "コメントを投稿できませんでした..." }
      end
    end
  end

  def edit
    @comment = @cook.comments.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = "コメントの編集中"
      format.js { render :edit }
    end
  end

  def update
    @comment = @cook.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        flash.now[:notice] = "コメントが編集されました"
        format.js { render :index }
      else
        flash.now[:notice] = "コメントの編集に失敗しました"
        format.js { render :edit }
      end
    end
  end

  def destroy 
    @comment = Comment.find(params[:id])
    if @comment.destroy 
      respond_to do |format|
        flash.now[:notice] = "コメントが削除されました"
        format.js { render :index }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:cook_id, :content)
  end

  def set_cook
    @cook = Cook.find(params[:cook_id])
  end
end
