class TasksController < ApplicationController
  before_action :set_task, only: %i(update show destroy)

  # GET /tasks
  def index
    @tasks = @user.tasks
  end

  # POST /tasks
  def create
    @task = @user.tasks.new(task_params)
    if @task.save
      render 'show'
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT  /tasks/:id
  def update
    if @task.update(task_params)
      render 'show'
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # GET /tasks/:id
  def show
  end

  # DELETE /tasks/:id
  def destroy
    if @task.destroy
      head :no_content
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :status, :task_list_id, :description)
  end

  def set_task
    @task = @user.tasks.find(params[:id])
  end
end