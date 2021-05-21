class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user_eq_user?,  only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice:"ログインしました！"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "プロフィールを更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to user_path, notice:"プロフィールを削除しました！"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def current_user_eq_user?
    redirect_to tasks_path if current_user.id != @user.id
  end
end