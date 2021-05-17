class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # @search_params = task_search_params
    # @tasks = Task.search(@search_params)
    if title.present? && progress.present?
      @tasks = Task.both_search(params[:title],params[:progress])
    elsif title.present?
      @tasks = Task.title_like(params[:title])
    elsif progress.present?
      @tasks = Task.progress_is(params[:progress])
    if params[:sort_params] == "limit" && "limit" != ""
      @tasks = Task.all.limit_sort
    else
      @tasks = Task.all.id_sort
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

  # def task_search_params
  #   params.fetch(:search, {}).permit(:title, :progress)
  # end
end