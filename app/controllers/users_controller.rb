class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy, :page]

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
    @cooks = @user.cooks.all
    @followings = @user.followings
    @followers = @user.followers
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
    if @user.destroy
      redirect_to users_path, notice: "ユーザーを削除しました!"
    else
      redirect_to users_path, alert: "最低一人の管理者か、#{@user.name}さんを削除できません"
    end
  end

  def page 
    @followings = @user.followings
    @followers = @user.followers
  end

  private

  def set_user 
    @user = User.find(params[:id])
  end 

  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)
  end
end
