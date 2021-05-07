class TsksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    if @task.save
       redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
       redirect_to tasks_path, notice: "タスクを更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end
end