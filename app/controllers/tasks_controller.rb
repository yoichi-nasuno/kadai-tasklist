class TasksController < ApplicationController
    before_action :require_user_logged_in
  def index
    @tasks = Task.all
  end 

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Taskが登録されました'
      redirect_to root_url
    else
      @tasks = curret_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'Taskが登録されませんでした'
      render 'tasks/index'
    end
  end 
  

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end 
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:status, :content)
  end 

end
