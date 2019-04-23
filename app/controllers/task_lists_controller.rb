class TaskListsController < ApplicationController
  before_action :set_task_list, only: %i(update show destroy)

  # GET / or /task_lists
  def index
    @task_lists = @user.task_lists
  end

  # POST /task_lists
  def create
    @task_list = @user.task_lists.new(task_list_params)
    if @task_list.save
      render 'show'
    else
      render json: @task_list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /task_lists/:id
  def update
    if @task_list.update(task_list_params)
      render 'show'
    else
      render json: @task_list.errors, status: :unprocessable_entity
    end
  end

  # GET /task_lists/:id
  def show
  end

  # DELETE /task_lists/:id
  def destroy
    if @task_list.destroy
      head :no_content
    else
      render json: @task_list.errors, status: :unprocessable_entity
    end
  end

  private

  def task_list_params
    params.require(:task_list).permit(:name, :status, :description)
  end

  def set_task_list
    @task_list = @user.task_lists.find(params[:id])
  end
end