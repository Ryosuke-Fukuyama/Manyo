class Admin::UsersController < ApplicationController
  # skip_before_action :login_required, only: [:new, :create]
  before_action :admin_required
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.created_at_sort.page(params[:page]).per(8)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
       redirect_to admin_user_path(@user.id), notice:"他ユーザーを作成しました！"
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice:"他ユーザーを削除しました！"
    else
      redirect_to admin_users_path, notice:"ユーザーを削除できませんでした！！"
    end
  end

  def show
  end

  def edit

  end

  def update
    @user.update(user_params)
    redirect_to admin_users_path, notice: "ロールを更新しました！"
  end

  private

  def admin_required
    unless current_user.admin?
      redirect_to tasks_path, notice:"管理者以外はアクセスできません！"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                 :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
