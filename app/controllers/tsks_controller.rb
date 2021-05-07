class TsksController < ApplicationController
  def index
    @tasks = Task.new
  end

  def show
  end

  def new
  end

  def edit
  end

  def create

    notice: "タスクを作成しました！"
  end

  def update

    notice: "タスクを更新しました！"
  end

  def destroy

    flash.now[:alert] = 'タスクを削除しました！'
  end
end
