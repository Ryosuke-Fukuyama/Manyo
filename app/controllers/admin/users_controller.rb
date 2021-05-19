class Admin::UsersController < ApplicationController
  # skip_before_action :login_required, only: [:new, :create]
  before_action :admin_required
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.page(params[:page]).per(8)
  end

  def new
    @admin_user = User.new
  end

  def create
    @admin_user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice:"管理者を作成しました！"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice:"ユーザーを削除しました！"
  end

  def show

  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "ロールを更新しました！"
    else
      render :edit
    end
  end

  private

  def admin_required
    if  current_user[:admin] != true
      redirect_to tasks_path, notice:"管理者以外はアクセスできません！" unless admin_user
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                 :image, :image_cache)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
