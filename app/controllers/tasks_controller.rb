class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    i = 8
    @search_params = task_search_params
    if params[:sort_params] == "limit"
       @tasks = current_user.tasks.all.limit_sort.page(params[:page]).per(i)
    elsif params[:sort_params] == "priority"
       @tasks = current_user.tasks.all.priority_sort.page(params[:page]).per(i)
    elsif
      @tasks = current_user.tasks.search(@search_params).page(params[:page]).per(i)
    elsif
      @tasks = current_user.tasks.all.id_sort.page(params[:page]).per(i)
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
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:title, :content, :limit, :progress, :priority)
  end

  def task_search_params
    params.fetch(:search, {}).permit(:title, :progress)
  end
end