class CooksController < ApplicationController
  before_action :set_cook, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  def index
    @cooks = Cook.all
  end

  def new
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
  end

  def edit
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
    redirect_to user_path(cook.user), notice: "レシピを削除しました。"
  end

  private

  def set_cook
    @cook = Cook.find(params[:id])
  end

  def cook_params
    params.require(:cook).permit(:title, :describe, :image, :image_cache)
  end
end