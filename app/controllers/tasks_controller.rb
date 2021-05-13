class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(id: :DESC)
    if params[:title].present? && params[:title] != ""
      @tasks = Task.title_search(params[:title])
    elsif params[:sort_params] == "limit" #|| params[:option] == nil
      @tasks = Task.all.order(limit: :DESC)
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
       redirect_to task_path(@task.id), notice: t('notice.save')
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
       redirect_to tasks_path, notice: t('notice.update')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('notice.destroy')
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :limit, :progress)
  end
end