class LabelsController < ApplicationController
  before_action :set_label, only: %i(show update destroy label_to_task_list
                                     label_to_task task_lists tasks task_lists_and_tasks)

  # GET /labels
  def index
    @labels = @user.labels
  end

  # POST /labels
  def create
    @label = @user.labels.new(label_params)
    if @label.save
      render 'show'
    else
      render json: @label.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT  /labels/:id
  def update
    if @label.update(label_params)
      render 'show'
    else
      render json: @label.errors, status: :unprocessable_entity
    end
  end

  # GET /labels/:id
  def show
  end

  # DELETE /labels/:id
  def destroy
    if @label.destroy
      head :no_content
    else
      render json: @label.errors, status: :unprocessable_entity
    end
  end

  # POST /labels/:id/assign_to_task_list
  def assign_to_task_list
    @label_task_list = @label.label_task_lists.new(task_list_id: params[:task_list_id])
    if @label_task_list.save
      render 'task_lists'
    else
      render json: @label_task_list.errors, status: :unprocessable_entity
    end
  end

  # GET /labels/:id/task_lists
  def task_lists
    @task_lists = @label.task_lists
  end

  # POST /labels/:id/assign_to_task
  def assign_to_task
    @label_task = @label.label_tasks.new(params[:task_id])
    if @label_task.save
      render 'tasks'
    else
      render json: @label_task.errors, status: :unprocessable_entity
    end
  end

  # GET /labels/:id/tasks
  def tasks
    @tasks = @label.tasks
  end

  # GET /labels/:id/task_lists_and_tasks
  def task_lists_and_tasks
    @task_lists = @label.task_lists
    @tasks = @label.tasks
  end

  private

  def label_params
    params.require(:label).permit(:name, :description)
  end

  def set_label
    @label = @user.labels.find(params[:id])
  end
end