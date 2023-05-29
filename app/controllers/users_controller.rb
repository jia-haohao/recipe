class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:new]
  def index
    @users = User.all
  end

  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    # @user = User.find(params[:id])
  end

  def edit
    if @user != current_user
      redirect_to user_path(current_user), alert: "不正なアクセスです。"
    end
  end

  def update 
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
    else 
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "削除しました!"
  end

  private

  def set_user 
    @user = User.find(params[:id])
  end 

  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)
  end
end
