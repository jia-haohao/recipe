class CooksController < ApplicationController
  load_and_authorize_resource
  before_action :set_cook, only: [:show, :edit, :update, :destroy]
  
  def index
    @q = Cook.ransack(params[:q])
    @cooks = @q.result(distinct: true).includes(:labels).order("created_at desc")
  end

  def new
    session[:cook_id] = nil
    @cook = Cook.new
  end

  def create 
    @cook = current_user.cooks.build(cook_params)
    if @cook.save
      redirect_to cook_path(@cook), notice: "レシピを投稿しました。"
    else
      render :new
    end
  end

  def show 
    @labels = @cook.labels.pluck(:name)
    @comments = @cook.comments
    @comment = @cook.comments.build
  end

  def edit
    session[:cook_id] = params[:id]
    @labels = @cook.labels.all
    if @cook.user != current_user
      redirect_to cooks_path, alert: "不正なアクセスです。"
    end
  end

  def update
    if @cook.update(cook_params)
      redirect_to cook_path(@cook), notice: "レシピを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @cook.destroy
    if current_user.admin
      CookMailer.cook_mail(@cook).deliver_now
    end
    redirect_to user_path(@cook.user), notice: "レシピを削除しました。"
  end

  private

  def set_cook
    @cook = Cook.find(params[:id])
  end

  def cook_params
    params.require(:cook).permit(:title, :describe, :image, :image_cache, { label_ids: [] })
  end
end
