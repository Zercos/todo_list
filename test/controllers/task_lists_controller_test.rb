require 'test_helper'

class TaskListsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
    @task_list = task_lists(:taskl1)
  end

  test 'should show all users task_lists in index' do
    get task_lists_path, headers: { 'AuthToken' => @user.auth_token }, as: :json

    parsed_body = JSON.parse response.body

    assert_response :success
    assert_equal @user.task_lists.count, parsed_body['task_lists'].count
  end

  test 'should render unprocessable_entity status + errors json if name is missing on create' do
    post task_lists_path, params: { name: '', status: 'in' },
                          headers: { 'AuthToken' => @user.auth_token }, as: :json

    assert_response :unprocessable_entity
  end

  test 'should update and render show' do
    patch  task_list_path(@task_list), params: { name: 'task_test', status: 'to' },
                                   headers: { 'AuthToken' => @user.auth_token }, as: :json

    parsed_body = JSON.parse response.body

    assert_response :success
    assert_equal 'to', @task_list.reload.status
    assert_equal @task_list.id, parsed_body['task_list']['id']
  end

  test 'should get show' do
    get task_list_path(@task_list), headers: { 'AuthToken' => @user.auth_token }, as: :json


    parsed_body = JSON.parse response.body

    assert_response :success
    assert_equal @task_list.name, parsed_body['task_list']['name']
  end

  test 'should get destroy' do
    assert_difference 'TaskList.count', -1 do
      delete task_list_path(@task_list), headers: { 'AuthToken' => @user.auth_token }
    end

    assert_response :no_content
  end
end