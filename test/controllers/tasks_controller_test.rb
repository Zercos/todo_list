require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @task = tasks(:task1)
    @user = users(:mike)
  end

  test 'should get all user tasks in index' do
    get tasks_path, headers: { 'AuthToken' => @user.auth_token }, as: :json

    parsed_body = JSON.parse response.body

    assert_response :success
    assert_equal @user.tasks.count, parsed_body['tasks'].count
  end

  test 'should render unprocessable_entity status + errors json if name is missing on create' do
    post tasks_path, params: { task: { name: '', status: 'in' }},
                     headers: { 'AuthToken' => @user.auth_token }, as: :json

    assert_response :unprocessable_entity
  end

  test 'should create task and render show on successful create' do
    assert_difference 'Task.count', 1 do
      post tasks_path, params: { task: { name: 'task2', status: 'out',
                                 task_list_id: @user.task_lists.take.id }},
                       headers: { 'AuthToken' => @user.auth_token }, as: :json
    end
    parsed_body = JSON.parse response.body
    new_task = @user.tasks.find(parsed_body['task']['id'])

    assert_response :success
    assert_equal 'task2', new_task.name
  end

  test 'should update and render show on update' do
    patch  task_path(@task), params: { task: { name: 'task_test', status: 'red' }},
                              headers: { 'AuthToken' => @user.auth_token }, as: :json

    parsed_body = JSON.parse response.body

    assert_equal 'red', @task.reload.status
    assert_equal @task.status, parsed_body['task']['status']
  end

  test 'should get show' do
    get task_path(@task), headers: { 'AuthToken' => @user.auth_token }, as: :json

    parsed_body = JSON.parse response.body

    assert_response :success
    assert_equal @task.id, parsed_body['task']['id']
  end

  test 'should get destroy' do
    assert_difference 'Task.count', -1 do
      delete task_path(@task), headers: { 'AuthToken' => @user.auth_token }
    end

    assert_response :no_content
  end
end