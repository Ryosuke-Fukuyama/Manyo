class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_labels, only: %i(index new edit create)

  def index
    @tasks = current_user.tasks
    @tasks = @tasks.order(limit: :desc) if params[:limit].present?
    @tasks = @tasks.order(priority: :desc) if params[:priority].present?
    @tasks = @tasks.order(created_at: :desc) unless params[:limit].present? && params[:priority].present?
    if params[:task].present?
      @tasks = @tasks.search_title(params[:task][:title]) if params[:task][:title].present?
      @tasks = @tasks.search_status(params[:task][:progress]) if params[:task][:progress].present?
      @tasks = @tasks.search_label(params[:task][:label_id]) if params[:task][:label_id].present?
    end

    @tasks = @tasks.page(params[:page]).per(8)


    # @search_params = task_search_params
    # @tasks = current_user.tasks.limit_sort if params[:sort_params] == "limit"
    # @tasks = current_user.tasks.priority_sort if params[:sort_params] == "priority"
    # if params[:label_id] != ""
    #   @tasks = current_user.tasks.joins(:labels).distinct.search(@search_params).page(params[:page]).per(i)
    # elsif
    #   @tasks = current_user.tasks.search(@search_params).page(params[:page]).per(i)
    # elsif
    #   @tasks = current_user.tasks.created_at_sort.page(params[:page]).per(i)
    # end
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

  def set_labels
    @labels = Label.all
  end

  def task_params
    params.require(:task).permit(:title, :content, :limit, :progress, :priority, { label_ids: [] })
  end

  # def task_search_params
  #   params.fetch(:search, {}).permit(:title, :progress, :label_id)
  # end
end